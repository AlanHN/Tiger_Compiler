#include <stdio.h>
#include <assert.h>
#include <string.h>
#include "util.h"
#include "errormsg.h"
#include "symbol.h"
#include "absyn.h"
#include "types.h"
#include "env.h"
#include "semant.h"
#include "helper.h"
#include "translate.h"

/*Lab5: Your implementation of lab5.*/

struct expty
{
	Tr_exp exp;
	Ty_ty ty;
};

//In Lab4, the first argument exp should always be **NULL**.
struct expty expTy(Tr_exp exp, Ty_ty ty)
{
	struct expty e;

	e.exp = exp;
	e.ty = ty;

	return e;
}

Ty_ty actual_ty(Ty_ty ty)
{
	if (ty == NULL)
	{
		return Ty_Void();
	}	
	
	if (ty->kind != Ty_name)
	{
		return ty;
	}
	else
	{
		return actual_ty(ty->u.name.ty);
	}
}

bool tyeq(Ty_ty ty1, Ty_ty ty2)
{
	Ty_ty at1 = actual_ty(ty1);
	Ty_ty at2 = actual_ty(ty2);

	switch (at1->kind)
	{
	case Ty_record:
	{
		return (at2->kind == Ty_nil || at1 == at2);
	}
	case Ty_array:
	{
		return (at1 == at2);
	}
	case Ty_nil:
	{
		return (at2->kind == Ty_record || at2->kind == Ty_nil);
	}
	default:
		return (at1->kind == at2->kind);
	}
}

struct expty transVar(S_table venv, S_table tenv, A_var v, Tr_level l, Temp_label t)
{
	switch (v->kind)
	{
	case A_simpleVar:
	{
		// a
		S_symbol simple = v->u.simple;
		E_enventry enventry = S_look(venv, simple);
		if (enventry !=NULL && enventry->kind == E_varEntry)
		{
			return expTy(Tr_simpleVar(enventry->u.var.access, l), actual_ty(enventry->u.var.ty));
		}
		else
		{
			EM_error(v->pos, "undefined variable %s", S_name(simple));
			return expTy(Tr_noExp(), Ty_Int());
		}
	}
	case A_fieldVar:
	{
		// A.a
		A_var var = v->u.field.var;
		struct expty e = transVar(venv, tenv, var, l, t);
		if (e.ty->kind != Ty_record)
		{
			EM_error(var->pos, "not a record type");
			return expTy(Tr_noExp(), Ty_Int());
		}
		else
		{
			int i = 0;
			Ty_fieldList record = e.ty->u.record;
			S_symbol sym = v->u.field.sym;
			for (; record != NULL; record = record->tail, i++)
			{
				S_symbol name = record->head->name;
				if (name == sym)
				{
					//find
					return expTy(Tr_fieldVar(e.exp, i), actual_ty(record->head->ty));
				}
			}
			EM_error(var->pos, "field %s doesn't exist", S_name(sym));
			return expTy(Tr_noExp(), Ty_Int());
		}
	}
	case A_subscriptVar:
	{
		A_var var = v->u.subscript.var;
		A_exp exp = v->u.subscript.exp;

		struct expty e1 = transVar(venv, tenv, var, l, t);
		struct expty e2 = transExp(venv, tenv, exp, l, t);

		if (e1.ty->kind != Ty_array)
		{
			EM_error(var->pos, "array type required");
			return expTy(Tr_noExp(), Ty_Int());
		}
		if (e2.ty->kind != Ty_int)
		{
			EM_error(exp->pos, "interger subscript required");
			return expTy(Tr_noExp(), Ty_Int());
		}
		return expTy(Tr_subscriptVar(e1.exp, e2.exp), actual_ty(e1.ty->u.array));
	}
	default:
		assert(0);
		break;
	}
}
struct expty transExp(S_table venv, S_table tenv, A_exp a, Tr_level l, Temp_label t)
{
	switch (a->kind)
	{
	case A_varExp:
	{
		A_var var = a->u.var;
		return transVar(venv, tenv, var, l, t);
	}
	case A_nilExp:
	{
		return expTy(Tr_nilExp(), Ty_Nil());
	}
	case A_intExp:
	{
		int intt = a->u.intt;
		return expTy(Tr_intExp(intt), Ty_Int());
	}
	case A_stringExp:
	{
		string stringg = a->u.stringg;
		return expTy(Tr_stringExp(stringg), Ty_String());
	}
	case A_callExp:
	{
		S_symbol func = a->u.call.func;
		E_enventry enventry = S_look(venv, func);
		if (enventry == NULL || enventry->kind != E_funEntry)
		{
			EM_error(a->pos, "undefined function %s", S_name(func));
			return expTy(Tr_noExp(), Ty_Void());
		}

		// check the formals and args
		Ty_tyList formals = enventry->u.fun.formals;
		A_expList args = a->u.call.args;
		Tr_expList head = NULL;
		Tr_expList tail = NULL;
		for (; formals != NULL; formals = formals->tail, args = args->tail)
		{
			if (args == NULL)
			{
				EM_error(a->pos, "para type mismatch");
				return expTy(Tr_noExp(), Ty_Void());
			}
			struct expty e = transExp(venv, tenv, args->head, l, t);
			if (!tyeq(e.ty, formals->head))
			{
				EM_error(a->pos, "para type mismatch");
				return expTy(Tr_noExp(), Ty_Void());
			}
			if (head == NULL)
			{
				head = tail = Tr_ExpList(e.exp, NULL);
			}
			else
			{
				tail->tail = Tr_ExpList(e.exp, NULL);
				tail = tail->tail;
			}
		}
		if (args != NULL)
		{
			EM_error(a->pos, "too many params in function %s", S_name(a->u.call.func));
			return expTy(Tr_noExp(), Ty_Void());
		}
		return expTy(Tr_callExp(enventry->u.fun.label, enventry->u.fun.level, l, head), actual_ty(enventry->u.fun.result));
	}
	case A_opExp:
	{
		A_exp left = a->u.op.left;
		A_exp right = a->u.op.right;
		A_oper oper = a->u.op.oper;

		struct expty e1 = transExp(venv, tenv, left, l, t);
		struct expty e2 = transExp(venv, tenv, right, l, t);
		if (oper == A_plusOp || oper == A_minusOp || oper == A_timesOp || oper == A_divideOp)
		{
			if (e1.ty->kind != Ty_int)
			{
				EM_error(left->pos, "integer required");
			}
			if (e2.ty->kind != Ty_int)
			{
				EM_error(right->pos, "integer required");
			}
			return expTy(Tr_binExp(oper, e1.exp, e2.exp), Ty_Int());
		}
		else if (oper == A_eqOp || oper == A_neqOp || oper == A_ltOp || oper == A_leOp || oper == A_gtOp || oper == A_geOp)
		{
			if (!tyeq(e1.ty, e2.ty))
			{
				EM_error(a->u.op.left->pos, "same type required");
			}
			if (e1.ty == Ty_String() && e2.ty == Ty_String())
			{
				return expTy(Tr_stringEqualExp(e1.exp, e2.exp), Ty_Int());
			}
			return expTy(Tr_relExp(oper, e1.exp, e2.exp), Ty_Int());
		}
		else
		{
			EM_error(a->u.op.left->pos, "wrong oper");
			assert(0);
		}
	}
	case A_recordExp:
	{
		S_symbol typ = a->u.record.typ;
		Ty_ty ty = S_look(tenv, typ);
		if (ty == NULL)
		{
			EM_error(a->pos, "undefined type %s", S_name(typ));
			return expTy(Tr_noExp(), Ty_Record(NULL));
		}

		int i = 0;
		Tr_expList head = NULL;
		Tr_expList tail = NULL;
		A_efieldList fields = a->u.record.fields;
		
		for (; fields != NULL; fields = fields->tail, i++)
		{
			struct expty e = transExp(venv, tenv, fields->head->exp, l, t);
			if (head == NULL)
			{
				head = tail = Tr_ExpList(e.exp, NULL);
			}
			else
			{
				tail->tail = Tr_ExpList(e.exp, NULL);
				tail = tail->tail;
			}
		}
		return expTy(Tr_recordExp(i, head), actual_ty(ty));
	}
	case A_seqExp:
	{
		A_expList seq = a->u.seq;
		if (seq == NULL)
		{
			return expTy(Tr_noExp(), Ty_Void());
		}
		struct expty e;
		Tr_expList head = NULL;
		Tr_expList tail = NULL;
		for (; seq != NULL; seq = seq->tail)
		{
			e = transExp(venv, tenv, seq->head, l, t);
			if (head == NULL)
			{
				head = tail = Tr_ExpList(e.exp, NULL);
			}
			else
			{
				tail->tail = Tr_ExpList(e.exp, NULL);
				tail = tail->tail;
			}
		}
		return expTy(Tr_seqExp(head), actual_ty(e.ty));
	}
	case A_assignExp:
	{
		A_var var = a->u.assign.var;
		A_exp exp = a->u.assign.exp;

		struct expty e1 = transExp(venv, tenv, exp, l, t);
		struct expty e2 = transVar(venv, tenv, var, l, t);

		if (!tyeq(e1.ty, e2.ty))
		{
			EM_error(a->pos, "unmatched assign exp");
		}
		// check loop variable in forExp
		if (var->kind == A_simpleVar)
		{
			E_enventry enventry = S_look(venv, var->u.simple);
			if (enventry!=NULL && enventry->kind == E_varEntry && enventry->readonly==1)
			{
				EM_error(a->pos, "loop variable can't be assigned");
			}
		}
		return expTy(Tr_assignExp(e2.exp, e1.exp), Ty_Void());
	}
	case A_ifExp:
	{
		A_exp test = a->u.iff.test;
		A_exp then = a->u.iff.then;
		A_exp elsee = a->u.iff.elsee;

		struct expty e1 = transExp(venv, tenv, test, l, t);
		struct expty e2 = transExp(venv, tenv, then, l, t);
		if (elsee == NULL)
		{
			if (e2.ty->kind != Ty_void)
			{
				EM_error(a->pos, "if-then exp's body must produce no value");
			}
			else
			{
				return expTy(Tr_ifExp(e1.exp, e2.exp, NULL), Ty_Void());
			}
		}
		else
		{
			struct expty e3 = transExp(venv, tenv, elsee, l, t);
			if (!tyeq(e2.ty, e3.ty))
			{
				EM_error(a->pos, "then exp and else exp type mismatch");
			}
			return expTy(Tr_ifExp(e1.exp, e2.exp, e3.exp), actual_ty(e2.ty));
		}
	}
	case A_whileExp:
	{
		A_exp test = a->u.whilee.test;
		A_exp body = a->u.whilee.body;
		struct expty e1 = transExp(venv, tenv, test, l, t);

		// for break
		Temp_label done = Temp_newlabel();
		struct expty e2 = transExp(venv, tenv, body, l, done);

		if (e2.ty->kind != Ty_void)
		{
			EM_error(a->pos, "while body must produce no value");
		}
		return expTy(Tr_whileExp(e1.exp, e2.exp, done), Ty_Void());
	}
	case A_forExp:
	{
		A_exp lo = a->u.forr.lo;
		A_exp hi = a->u.forr.hi;
		A_exp body = a->u.forr.body;
		S_symbol var = a->u.forr.var;

		struct expty e1 = transExp(venv, tenv, lo, l, t);
		struct expty e2 = transExp(venv, tenv, hi, l, t);

		if (e1.ty->kind != Ty_int)
		{
			EM_error(lo->pos, "for exp's range type is not integer");
		}
		if (e2.ty->kind != Ty_int)
		{
			EM_error(hi->pos, "for exp's range type is not integer");
		}

		Tr_access access = Tr_allocLocal(l, TRUE);

		S_beginScope(venv);
		S_enter(venv, var, E_ROVarEntry(access, Ty_Int()));
		Temp_label done = Temp_newlabel();
		struct expty e3 = transExp(venv, tenv, body, l, done);
		if (e3.ty->kind != Ty_void)
		{
			EM_error(body->pos, "for body must produce no value");
		}
		S_endScope(venv);

		return expTy(Tr_forExp(access, e1.exp, e2.exp, e3.exp, done), Ty_Void());
	}
	case A_breakExp:
	{
		if (!t)
		{
			return expTy(Tr_noExp(), Ty_Void());
		}
		return expTy(Tr_breakExp(t), Ty_Void());
	}
	case A_letExp:
	{
		
		A_decList decs = a->u.let.decs;
		A_exp body = a->u.let.body;
		Tr_expList head = NULL;
		Tr_expList tail = NULL;

		S_beginScope(venv);
		S_beginScope(tenv);

		for (; decs!=NULL; decs = decs->tail)
		{
			Tr_exp exp = transDec(venv, tenv, decs->head, l, t);
			if (head == NULL)
			{
				head = tail = Tr_ExpList(exp, NULL);
			}
			else
			{
				tail->tail = Tr_ExpList(exp, NULL);
				tail = tail->tail;
			}
		}
		struct expty e = transExp(venv, tenv, body, l, t);
		tail->tail = Tr_ExpList(e.exp, NULL);
		S_endScope(tenv);
		S_endScope(venv);

		return expTy(Tr_seqExp(head), actual_ty(e.ty));
	}
	case A_arrayExp:
	{
		S_symbol typ = a->u.array.typ;
		Ty_ty ty = S_look(tenv,typ);

		A_exp size = a->u.array.size;
		A_exp init = a->u.array.init;
		struct expty e1 = transExp(venv, tenv, size, l, t);
		struct expty e2 = transExp(venv, tenv, init, l, t);

		if (!tyeq(e2.ty, actual_ty(ty)->u.array))
		{
			EM_error(a->pos, "type mismatch");
			return expTy(Tr_noExp(), Ty_Int());
		}
		return expTy(Tr_arrayExp(e1.exp, e2.exp), actual_ty(ty));
	}
	default:
	{
		assert(0);
		break;
	}
	}
}

static Ty_tyList makeFormalTyList(S_table tenv, A_fieldList f)
{
	//attention: don't change f
	A_fieldList params = f;
	Ty_tyList head = NULL;
	Ty_tyList tail = NULL;
	
	for (; params != NULL; params = params->tail)
	{
		S_symbol typ = params->head->typ;
		Ty_ty ty = S_look(tenv, typ);
		if (ty == NULL)
		{
			EM_error(params->head->pos, "undefined type %s", S_name(typ));
			// default int
			ty = Ty_Int();
		}
		if (head == NULL)
		{
			head = tail = Ty_TyList(ty, NULL);
		}
		else
		{
			tail->tail = Ty_TyList(ty, NULL);
			tail = tail->tail;
		}
	}
	return head;
}

static U_boolList makeFormalBoolList(A_fieldList f)
{
	A_fieldList params = f;
	U_boolList head = NULL;
	U_boolList tail = NULL;
	for (; params != NULL; params = params->tail)
	{
		bool escape = params->head->escape;
		if (head == NULL)
		{
			head = tail = U_BoolList(escape, NULL);
		}
		else
		{
			tail->tail = U_BoolList(escape, NULL);
			tail = tail->tail;
		}
	}
	return head;
}

Tr_exp transDec(S_table venv, S_table tenv, A_dec d, Tr_level l, Temp_label t)
{
	switch (d->kind)
	{
	case A_functionDec:
	{
		A_fundecList function = d->u.function;
		A_fundecList function2 = d->u.function;
		A_fundec f = NULL;

        //first iteration: handle the head
		for (; function != NULL; function = function->tail)
		{
			Ty_ty resultTy = NULL;

			A_fundec f = function->head;
			// check same function name
			for (; function2 != function; function2 = function2->tail)
			{
				A_fundec f2 = function2->head;
				if (f2->name == f->name)
				{
					EM_error(f->pos, "two functions have the same name");
					break;
				}
			}
			// get result type
			if (f->result == NULL)
			{
				resultTy = Ty_Void();
			}
			else
			{
				resultTy = S_look(tenv, f->result);
			}

			Ty_tyList formalTys = makeFormalTyList(tenv, f->params);
			U_boolList formalEscapes = makeFormalBoolList(f->params);

			// new frame
			Temp_label newLabel = Temp_namedlabel(S_name(f->name));
			Tr_level newLevel = Tr_newLevel(l, newLabel, formalEscapes);

			// enter the FunEntry
			S_enter(venv, f->name, E_FunEntry(newLevel, newLabel, formalTys, resultTy));
		}

        //second iteration: handle the body
		for (function = d->u.function; function != NULL; function = function->tail)
		{
			f = function->head;

			E_enventry enventry = S_look(venv, f->name);
			A_fieldList params = f->params;
			Ty_tyList formals = enventry->u.fun.formals;
			Tr_level level = enventry->u.fun.level;
			Tr_accessList fmls = Tr_formals(level);

			S_beginScope(venv);
			// enter the body
			for (; params != NULL; params = params->tail, formals = formals->tail, fmls = fmls->tail)
			{
				S_enter(venv, params->head->name, E_VarEntry(fmls->head, formals->head));
			}

			struct expty e = transExp(venv, tenv, f->body, level, t);

			// check return
			Ty_ty result = enventry->u.fun.result;
			if (result->kind == Ty_void && e.ty->kind != Ty_void)
			{
				EM_error(f->pos, "procedure returns value");
			}
			// exit
			Tr_procEntryExit(level, e.exp, fmls);
			S_endScope(venv);
		}
		return Tr_noExp();
	}
	case A_varDec:
	{
		A_exp init = d->u.var.init;
		bool escape = d->u.var.escape;
		S_symbol var = d->u.var.var;
		S_symbol typ = d->u.var.typ;

		struct expty e = transExp(venv, tenv, init, l, t);
		Tr_access access = Tr_allocLocal(l, escape);

		if (typ == NULL)
		{
			if (e.ty->kind == Ty_nil)
			{
				EM_error(d->pos, "init should not be nil without type specified");
				S_enter(venv, var, E_VarEntry(access, Ty_Int()));
			}
			else
			{
				S_enter(venv, d->u.var.var, E_VarEntry(access, e.ty));
			}
		}
		else
		{
			Ty_ty ty = S_look(tenv, typ);
			if (ty == NULL)
			{
				EM_error(d->pos, "undefined type %s", S_name(typ));
			}
			if (!tyeq(ty, e.ty))
			{
				EM_error(d->pos, "type mismatch");
			}
			S_enter(venv, var, E_VarEntry(access, ty));
		}
		return Tr_assignExp(Tr_simpleVar(access, l), e.exp);
	}
	case A_typeDec:
	{
		A_nametyList type = d->u.type;

		// check same name
		for (; type != NULL; type = type->tail)
		{
			for (A_nametyList type2 = d->u.type; type2 != type; type2 = type2->tail)
			{
				if (type2->head->name == type->head->name)
				{
					EM_error(d->pos, "two types have the same name");
					break;
				}
			}
			S_enter(tenv, type->head->name, Ty_Name(type->head->name, NULL));
		}
		// put actual ty
		for (type = d->u.type; type; type = type->tail)
		{
			Ty_ty ty = S_look(tenv, type->head->name);
			ty->u.name.ty = transTy(tenv, type->head->ty);
		}
		// check cycle
		bool cycle = FALSE;
		for (type = d->u.type; type; type = type->tail)
		{
			Ty_ty ty = S_look(tenv, type->head->name);
			Ty_ty ty2 = ty;
			while (ty2->kind == Ty_name)
			{
				ty2 = ty2->u.name.ty;
				if (ty2 == ty)
				{
					EM_error(d->pos, "illegal type cycle");
					cycle = TRUE;
					break;
				}
			}
			if (cycle)
				break;
		}
		return Tr_noExp();
	}
	default:
	{
		assert(0);
		break;
	}
	}
}

Ty_ty transTy(S_table tenv, A_ty a)
{
	switch (a->kind)
	{
	case A_nameTy:
	{
		S_symbol name = a->u.name;
		Ty_ty ty = S_look(tenv, name);
		if (ty != NULL)
		{
			return ty;
		}
		else
		{
			EM_error(a->pos, "undefined type %s", S_name(name));
			// default int
			return Ty_Int();
		}
	}
	case A_recordTy:
	{
		A_fieldList record = a->u.record;
		Ty_fieldList head = NULL;
		Ty_fieldList tail = NULL;

		for (; record != NULL; record = record->tail)
		{
			S_symbol typ = record->head->typ;
			Ty_ty ty = S_look(tenv, typ);
			// check typ
			if (ty == NULL)
			{
				EM_error(record->head->pos, "undefined type %s", S_name(typ));
				// default int
				ty = Ty_Int();
			}
			S_symbol name = record->head->name;
			if (head == NULL)
			{
				head = tail = Ty_FieldList(Ty_Field(name, ty), NULL);
			}
			else
			{
				tail->tail = Ty_FieldList(Ty_Field(name, ty), NULL);
				tail = tail->tail;
			}
		}
		return Ty_Record(head);
	}
	case A_arrayTy:
	{
		S_symbol array = a->u.array;
		Ty_ty ty = S_look(tenv, array);
		if (ty != NULL)
		{
			return Ty_Array(ty);
		}
		else
		{
			EM_error(a->pos, "undefined type %s", S_name(array));
			// default int
			return Ty_Array(Ty_Int());
		}
	}
	default:
	{
		assert(0);
		break;
	}
	}
}

F_fragList SEM_transProg(A_exp exp)
{
	//TODO LAB5: do not forget to add the main frame
	//init
	F_FP(); 
	F_SP();
	F_RV();
	S_table tenv = E_base_tenv();
	S_table venv = E_base_venv();
	Temp_label mainLabel = Temp_namedlabel("tigermain");
	Tr_level mainLevel = Tr_newLevel(Tr_outermost(), mainLabel, NULL);

	struct expty main = transExp(venv, tenv, exp, mainLevel, NULL);

	Tr_procEntryExit(mainLevel, main.exp, NULL);
	return Tr_getResult();
}
