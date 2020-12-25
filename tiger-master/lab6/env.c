// #include <stdio.h>
// #include "util.h"
// #include "symbol.h"
// #include "env.h" 

// /*Lab4: Your implementation of lab4*/

// E_enventry E_VarEntry(Tr_access access, Ty_ty ty)
// {
// 	E_enventry entry = checked_malloc(sizeof(*entry));

// 	entry->kind = E_varEntry;
// 	entry->u.var.access = access;
// 	entry->u.var.ty = ty;
// 	entry->readonly = 0;
// 	return entry;
// }

// E_enventry E_ROVarEntry(Tr_access access, Ty_ty ty)
// {
// 	E_enventry entry = checked_malloc(sizeof(*entry));

// 	entry->kind = E_varEntry;
// 	entry->u.var.access = access;
// 	entry->u.var.ty = ty;
// 	entry->readonly = 1;
// 	return entry;
// }

// E_enventry E_FunEntry(Tr_level level, Temp_label label, Ty_tyList formals, Ty_ty result)
// {
// 	E_enventry entry = checked_malloc(sizeof(*entry));

// 	entry->kind = E_funEntry;
// 	entry->u.fun.level = level;
// 	entry->u.fun.label = label;
// 	entry->u.fun.formals = formals;
// 	entry->u.fun.result = result;
// 	return entry;
// }

// E_enventry E_EscapeEntry(int depth, bool *escape)
// {
// 	E_enventry entry = checked_malloc(sizeof(*entry));

// 	entry->kind = E_escapeEntry;
// 	entry->u.esc.depth = depth;
// 	entry->u.esc.escape = escape;
// 	return entry;
// }

// //sym->value
// //type_id(name, S_symbol) -> type (Ty_ty)
// S_table E_base_tenv(void)
// {
// 	S_table table;
// 	S_symbol ty_int;
// 	S_symbol ty_string;

// 	table = S_empty();

// 	//basic type: string
// 	ty_int = S_Symbol("int");
// 	S_enter(table, ty_int, Ty_Int());	

// 	//basic type: string
// 	ty_string = S_Symbol("string");
// 	S_enter(table, ty_string, Ty_String());	

// 	return table;
// }

// S_table E_base_venv(void)
// {
// 	S_table venv;

// 	Ty_ty result;
// 	Ty_tyList formals;
	
// 	Temp_label label = NULL;
// 	Tr_level level;
	
// 	level = Tr_outermost();
// 	venv = S_empty();

// 	label = Temp_namedlabel("flush");
// 	S_enter(venv,S_Symbol("flush"),E_FunEntry(level,label,NULL,NULL));
	
// 	result = Ty_Int();

// 	formals = checked_malloc(sizeof(*formals));
// 	formals->head = Ty_Int();
// 	formals->tail = NULL;
// 	label = Temp_namedlabel("exit");
// 	S_enter(venv,S_Symbol("exit"),E_FunEntry(level,label,formals,NULL));
// 	label = Temp_namedlabel("not");
// 	S_enter(venv,S_Symbol("not"),E_FunEntry(level,label,formals,result));

// 	result = Ty_String();
// 	label = Temp_namedlabel("chr");
// 	S_enter(venv,S_Symbol("chr"),E_FunEntry(level,label,formals,result));
// 	label = Temp_namedlabel("getchar");
// 	S_enter(venv,S_Symbol("getchar"),E_FunEntry(level,label,NULL,result));

// 	formals = checked_malloc(sizeof(*formals));
// 	formals->head = Ty_String();
// 	formals->tail = NULL;
// 	label = Temp_namedlabel("print");
// 	S_enter(venv,S_Symbol("print"),E_FunEntry(level,label,formals,NULL));

// 	result = Ty_Int();
// 	label = Temp_namedlabel("ord");
// 	S_enter(venv,S_Symbol("ord"),E_FunEntry(level,label,formals,result));
// 	label = Temp_namedlabel("size");
// 	S_enter(venv,S_Symbol("size"),E_FunEntry(level,label,formals,result));

// 	result = Ty_String();
// 	formals = checked_malloc(sizeof(*formals));
// 	formals->head = Ty_String();
// 	formals->tail = checked_malloc(sizeof(*formals));
// 	formals->tail->head = Ty_String();
// 	label = Temp_namedlabel("concat");
// 	S_enter(venv,S_Symbol("concat"),E_FunEntry(level,label,formals,result));

// 	formals = checked_malloc(sizeof(*formals));
// 	formals->head = Ty_String();
// 	formals->tail = checked_malloc(sizeof(*formals));
// 	formals->tail->head = Ty_Int();
// 	formals->tail->tail = checked_malloc(sizeof(*formals));
// 	formals->tail->tail->head = Ty_Int();
// 	label = Temp_namedlabel("substring");
// 	S_enter(venv,S_Symbol("substring"),E_FunEntry(level,label,formals,result));

// 	formals = checked_malloc(sizeof(*formals));
// 	formals->head = Ty_Int();
// 	formals->tail = NULL;
// 	label = Temp_namedlabel("printi");
// 	S_enter(venv,S_Symbol("printi"),E_FunEntry(level,label,formals,NULL));	

// 	return venv;
// }
#include <stdio.h>
#include "util.h"
#include "symbol.h"
#include "env.h" 

/*Lab4: Your implementation of lab4*/
E_enventry E_VarEntry(Tr_access access, Ty_ty ty)
{
	E_enventry entry = checked_malloc(sizeof(*entry));

	entry->kind = E_varEntry;
	entry->u.var.access = access;
	entry->u.var.ty = ty;
	entry->readonly = 0;
	return entry;
}

E_enventry E_ROVarEntry(Tr_access access, Ty_ty ty)
{
	E_enventry entry = checked_malloc(sizeof(*entry));

	entry->kind = E_varEntry;
	entry->u.var.access = access;
	entry->u.var.ty = ty;
	entry->readonly = 1;
	return entry;
}

E_enventry E_FunEntry(Tr_level level, Temp_label label, Ty_tyList formals, Ty_ty result)
{
	E_enventry entry = checked_malloc(sizeof(*entry));

entry->kind = E_funEntry;
	entry->u.fun.level = level;
	entry->u.fun.label = label;
	entry->u.fun.formals = formals;
	entry->u.fun.result = result;
	return entry;
}

E_enventry E_EscapeEntry(int depth, bool *escape)
{
	E_enventry entry = checked_malloc(sizeof(*entry));

	entry->kind = E_escapeEntry;
	entry->u.esc.depth = depth;
	entry->u.esc.escape = escape;
	return entry;
}


//sym->value
//type_id(name, S_symbol) -> type (Ty_ty)
S_table E_base_tenv(void)
{
	S_table table;
	S_symbol ty_int;
	S_symbol ty_string;

	table = S_empty();

	//basic type: string
	ty_int = S_Symbol("int");
	S_enter(table, ty_int, Ty_Int());	

	//basic type: string
	ty_string = S_Symbol("string");
	S_enter(table, ty_string, Ty_String());	

	return table;
}

S_table E_base_venv(void)
{
	S_table venv;

	Ty_ty result;
	Ty_tyList formals;
	
	Temp_label label = NULL;
	Tr_level level;
	
	level = Tr_outermost();
	venv = S_empty();

	label = Temp_namedlabel("flush");
	S_enter(venv,S_Symbol("flush"),E_FunEntry(level,label,NULL,NULL));
	
	result = Ty_Int();

	formals = checked_malloc(sizeof(*formals));
	formals->head = Ty_Int();
	formals->tail = NULL;

	label = Temp_namedlabel("exit");
	S_enter(venv,S_Symbol("exit"),E_FunEntry(level,label,formals,NULL));

	label = Temp_namedlabel("not");
	S_enter(venv,S_Symbol("not"),E_FunEntry(level,label,formals,result));

	result = Ty_String();

	label = Temp_namedlabel("chr");
	S_enter(venv,S_Symbol("chr"),E_FunEntry(level,label,formals,result));

	label = Temp_namedlabel("getchar");
	S_enter(venv,S_Symbol("getchar"),E_FunEntry(level,label,NULL,result));

	formals = checked_malloc(sizeof(*formals));
	formals->head = Ty_String();
	formals->tail = NULL;
	
label = Temp_namedlabel("print");
	S_enter(venv,S_Symbol("print"),E_FunEntry(level,label,formals,NULL));

	result = Ty_Int();
	label = Temp_namedlabel("ord");
	S_enter(venv,S_Symbol("ord"),E_FunEntry(level,label,formals,result));
	label = Temp_namedlabel("size");
	S_enter(venv,S_Symbol("size"),E_FunEntry(level,label,formals,result));

	result = Ty_String();
	formals = checked_malloc(sizeof(*formals));
	formals->head = Ty_String();
	formals->tail = checked_malloc(sizeof(*formals));
	formals->tail->head = Ty_String();
	label = Temp_namedlabel("concat");
	S_enter(venv,S_Symbol("concat"),E_FunEntry(level,label,formals,result));

	formals = checked_malloc(sizeof(*formals));
	formals->head = Ty_String();
	formals->tail = checked_malloc(sizeof(*formals));
	formals->tail->head = Ty_Int();
	formals->tail->tail = checked_malloc(sizeof(*formals));
	formals->tail->tail->head = Ty_Int();
	label = Temp_namedlabel("substring");
	S_enter(venv,S_Symbol("substring"),E_FunEntry(level,label,formals,result));

    formals = checked_malloc(sizeof(*formals));
	formals->head = Ty_Int();
	formals->tail = NULL;
	label = Temp_namedlabel("printi");
	S_enter(venv,S_Symbol("printi"),E_FunEntry(level,label,formals,NULL));	

	return venv;
}
