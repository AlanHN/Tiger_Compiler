// #include <stdio.h>
// #include <string.h>
// #include "util.h"
// #include "symbol.h"
// #include "absyn.h"
// #include "escape.h"
// #include "table.h"
// #include "env.h"
// #include "helper.h"

// static void traverseDec(S_table env, int depth, A_dec d);
// static void traverseVar(S_table env, int depth, A_var v);
// static void traverseExp(S_table env, int depth, A_exp e)
// {
// 	switch (e->kind)
// 	{
// 	case A_varExp:
// 	{
// 		traverseVar(env, depth, e->u.var);
// 		return;
// 	}
// 	case A_callExp:
// 	{
// 		A_expList args;
// 		for (args = get_callexp_args(e); args; args = args->tail)
// 		{
// 			traverseExp(env, depth, args->head);
// 		}
// 		return;
// 	}
// 	case A_opExp:
// 	{
// 		traverseExp(env, depth, get_opexp_left(e));
// 		traverseExp(env, depth, get_opexp_right(e));
// 		return;
// 	}
// 	case A_recordExp:
// 	{
// 		A_efieldList el = get_recordexp_fields(e);
// 		for (; el; el = el->tail)
// 		{
// 			traverseExp(env, depth, el->head->exp);
// 		}
// 		return;
// 	}
// 	case A_seqExp:
// 	{
// 		A_expList expList = get_seqexp_seq(e);
// 		for (; expList; expList = expList->tail)
// 		{
// 			traverseExp(env, depth, expList->head);
// 		}
// 		return;
// 	}
// 	case A_assignExp:
// 	{
// 		traverseExp(env, depth, get_assexp_exp(e));
// 		traverseVar(env, depth, get_assexp_var(e));
// 		return;
// 	}
// 	case A_ifExp:
// 	{
// 		traverseExp(env, depth, get_ifexp_test(e));
// 		traverseExp(env, depth, get_ifexp_then(e));
// 		if (get_ifexp_else(e))
// 		{
// 			traverseExp(env, depth, get_ifexp_else(e));
// 		}
// 		return;
// 	}
// 	case A_whileExp:
// 	{
// 		traverseExp(env, depth, get_whileexp_test(e));
// 		traverseExp(env, depth, get_whileexp_body(e));
// 		return;
// 	}
// 	case A_forExp:
// 	{
// 		traverseExp(env, depth, get_forexp_lo(e));
// 		traverseExp(env, depth, get_forexp_hi(e));
// 		S_beginScope(env);
// 		get_forexp_escape(e) = FALSE;
// 		S_enter(env, get_forexp_var(e), E_EscapeEntry(depth, &(get_forexp_escape(e))));
// 		traverseExp(env, depth, get_forexp_body(e));
// 		S_endScope(env);
// 		return;
// 	}
// 	case A_letExp:
// 	{
// 		S_beginScope(env);
// 		A_decList d = get_letexp_decs(e);
// 		for (; d; d = d->tail)
// 		{
// 			traverseDec(env, depth, d->head);
// 		}
// 		traverseExp(env, depth, get_letexp_body(e));
// 		S_endScope(env);
// 		return;
// 	}
// 	case A_arrayExp:
// 	{
// 		traverseExp(env, depth, get_arrayexp_size(e));
// 		traverseExp(env, depth, get_arrayexp_init(e));
// 		return;
// 	}
// 	default:
// 		return;
// 	}
// }

// static void traverseDec(S_table env, int depth, A_dec d)
// {
// 	switch (d->kind)
// 	{
// 	case A_functionDec:
// 	{
// 		A_fundecList fl;
// 		for (fl = get_funcdec_list(d); fl; fl = fl->tail)
// 		{
// 			S_beginScope(env);
// 			A_fieldList l;
// 			for (l = fl->head->params; l; l = l->tail)
// 			{
// 				l->head->escape = FALSE;
// 				S_enter(env, l->head->name, E_EscapeEntry(depth + 1, &(l->head->escape)));
// 			}
// 			traverseExp(env, depth + 1, fl->head->body);
// 			S_endScope(env);
// 		}
// 		return;
// 	}
// 	case A_varDec:
// 	{
// 		traverseExp(env, depth, get_vardec_init(d));
// 		get_vardec_escape(d) = FALSE;
// 		S_enter(env, get_vardec_var(d), E_EscapeEntry(depth, &(get_vardec_escape(d))));
// 		return;
// 	}
// 	case A_typeDec:
// 	{
// 		return;
// 	}
// 	}
// }

// static void traverseVar(S_table env, int depth, A_var v)
// {
// 	switch (v->kind)
// 	{
// 	case A_simpleVar:
// 	{
// 		E_enventry x = S_look(env, get_simplevar_sym(v));
// 		if (x && depth > x->u.esc.depth)
// 		{
// 			*(x->u.esc.escape) = TRUE;
// 		}
// 		return;
// 	}
// 	case A_fieldVar:
// 	{
// 		traverseVar(env, depth, get_fieldvar_var(v));
// 		return;
// 	}
// 	case A_subscriptVar:
// 	{
// 		traverseVar(env, depth, get_subvar_var(v));
// 		traverseExp(env, depth, get_subvar_exp(v));
// 		return;
// 	}
// 	}
// }

// void Esc_findEscape(A_exp exp)
// {
// 	S_table env = S_empty();
// 	traverseExp(env, 0, exp);
// }
#include <stdio.h>
#include <string.h>
#include "util.h"
#include "symbol.h"
#include "absyn.h"
#include "escape.h"
#include "table.h"
#include "env.h"

static void traverseExp(S_table env, int depth, A_exp e);
static void traverseDec(S_table env, int depth, A_dec d);
static void traverseVar(S_table env, int depth, A_var v);

void Esc_findEscape(A_exp exp)
{
	//your code here
	S_table env = S_empty();
	// tranverse from 0 level
	traverseExp(env, 0, exp);
}

static void traverseExp(S_table env, int depth, A_exp e)
{
	switch (e->kind)
	{
	case A_varExp:
	{
		traverseVar(env, depth, e->u.var);
		break;
	}
	case A_nilExp:
	{
		// need do nothing
		break;
	}
	case A_intExp:
	{
		// need do nothing
		break;
	}
	case A_stringExp:
	{
		// need do nothing
		break;
	}
	case A_callExp:
	{
		A_expList args = e->u.call.args;
		for (; args != NULL; args = args->tail)
		{
			traverseExp(env, depth, args->head);
		}
		break;
	}
	case A_opExp:
	{
		A_exp left = e->u.op.left;
		A_exp right = e->u.op.right;
		traverseExp(env, depth, left);
		traverseExp(env, depth, right);
		break;
	}
	case A_recordExp:
	{
		A_efieldList fields = e->u.record.fields;
		for (; fields != NULL; fields = fields->tail)
		{
			traverseExp(env, depth, fields->head->exp);
		}
		break;
	}
	case A_seqExp:
	{
		A_expList seq = e->u.seq;
		for (; seq != NULL; seq = seq->tail)
		{
			traverseExp(env, depth, seq->head);
		}
		break;
	}
	case A_assignExp:
	{
		A_var var = e->u.assign.var;
		A_exp exp = e->u.assign.exp;
		traverseExp(env, depth, exp);
		traverseVar(env, depth, var);
		break;
	}
	case A_ifExp:
	{
		A_exp test = e->u.iff.test;
		A_exp then = e->u.iff.then;
		A_exp elsee = e->u.iff.elsee;
		traverseExp(env, depth, test);
		traverseExp(env, depth, then);
		if (elsee != NULL)
		{
			traverseExp(env, depth, elsee);
		}
		break;
	}
	case A_whileExp:
	{
		A_exp test = e->u.whilee.test;
		A_exp body = e->u.whilee.body;
		traverseExp(env, depth, test);
		traverseExp(env, depth, body);
		break;
	}
	case A_forExp:
	{
		A_exp lo = e->u.forr.lo;
		A_exp hi = e->u.forr.hi;
		A_exp body = e->u.forr.body;
		S_symbol var = e->u.forr.var;

		traverseExp(env, depth, lo);
		traverseExp(env, depth, hi);

		//declares here
		S_beginScope(env);
		e->u.forr.escape = FALSE;
		S_enter(env, var, E_EscapeEntry(depth, &(e->u.forr.escape)));
		traverseExp(env, depth, body);
		S_endScope(env);

		break;
	}
	case A_breakExp:
	{
		// need do nothing
		break;
	}
	case A_letExp:
	{
		A_decList decs = e->u.let.decs;
		A_exp body = e->u.let.body;

		// declares here
		S_beginScope(env);
		for (; decs != NULL; decs = decs->tail)
		{
			traverseDec(env, depth, decs->head);
		}
		traverseExp(env, depth, body);
		S_endScope(env);
		break;
	}
	case A_arrayExp:
	{
		A_exp size = e->u.array.size;
		A_exp init = e->u.array.init;

		traverseExp(env, depth, size);
		traverseExp(env, depth, init);
		break;
	}
	default:
	{
		assert(0);
		break;
	}
	}
}

static void traverseDec(S_table env, int depth, A_dec d)
{
	switch (d->kind)
	{ 
	case A_functionDec:
	{
		A_fundecList function = d->u.function;

		for (; function != NULL; function = function->tail)
		{
			A_fieldList params = function->head->params;
			A_exp body = function->head->body;

			S_beginScope(env);
			for (; params != NULL; params = params->tail)
			{
				S_symbol name = params->head->name;
				params->head->escape = FALSE;
				S_enter(env, name, E_EscapeEntry(depth + 1, &(params->head->escape)));
			}
			traverseExp(env, depth + 1, body);
			S_endScope(env);
		}
		break;
	}
	case A_varDec:
	{
		S_symbol var = d->u.var.var;
		A_exp init = d->u.var.init;

		// in the let scope
		d->u.var.escape = FALSE;
		S_enter(env, var, E_EscapeEntry(depth, &(d->u.var.escape)));

		break;
	}
	case A_typeDec:
	{
		// need do nothing
		break;
	}
	default:
	{
		assert(0);
		break;
	}
	}
}

static void traverseVar(S_table env, int depth, A_var v)
{
	switch (v->kind)
	{
	case A_simpleVar:
	{
		S_symbol simple = v->u.simple;
		E_enventry enventry = S_look(env, simple);
		if (enventry != NULL && depth > enventry->u.esc.depth)
		{
			*(enventry->u.esc.escape) = TRUE;
		}
		break;
	}
	case A_fieldVar:
	{
		A_var var = v->u.field.var;
		traverseVar(env, depth, var);
		break;
	}
	case A_subscriptVar:
	{
		A_var var = v->u.subscript.var;
		A_exp exp = v->u.subscript.exp;
		traverseVar(env, depth, var);
		traverseExp(env, depth, exp);
		break;
	}
	default:
	{
		assert(0);
		break;
	}
	}
}