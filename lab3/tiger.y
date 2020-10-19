/* Lab3: You are free to modify this file (**ONLY** modify this file). 
 * But for your convinience, 
 * please read absyn.h carefully first.
 */

%{
#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "symbol.h" 
#include "errormsg.h"
#include "absyn.h"

int yylex(void); /* function prototype */

A_exp absyn_root;

void yyerror(char *s)
{
 EM_error(EM_tokPos, "%s", s);
 exit(1);
}
%}

/* the fields in YYTYPE */
%union {
	int pos;
	int ival;
	string sval;
	A_var var;
	A_exp exp;
	A_expList expList;
	A_dec dec;
	A_decList decList;
	A_fundec fundec;
	A_fundecList fundecList;
	A_namety namety;
	A_nametyList nametyList;
	A_field field;
	A_fieldList fieldList;
	A_efield efield;
	A_efieldList efieldList;
	A_ty ty;
}

%token <sval> ID STRING
%token <ival> INT

%token 
  COMMA COLON SEMICOLON LPAREN RPAREN LBRACK RBRACK 
  LBRACE RBRACE DOT 
  PLUS MINUS TIMES DIVIDE EQ NEQ LT LE GT GE
  AND OR ASSIGN
  ARRAY IF THEN ELSE WHILE FOR TO DO LET IN END OF 
  BREAK NIL
  FUNCTION VAR TYPE 

%left OR
%left AND
%nonassoc EQ NEQ LT GT LE GE
%left PLUS MINUS
%left TIMES DIVIDE
%left UMINUS

%type <exp> exp program voidexp seqexp
%type <var> lvalue
%type <expList> args exps
%type <ty> ty
%type <dec> dec vardec 
%type <fundec> fundec
%type <fundecList> fundecs
%type <namety> tydec
%type <nametyList> tydecs
%type <decList> decs
%type <field> tyfield
%type <fieldList> tyfields
%type <efield> recorditem 
%type <efieldList> recorditems

/* Lab3: One solution: you can fill the following rules directly.
 * Of course, you can modify (add, delete or change) any rules.
 */
%start program

%%

program: exp  {absyn_root=$1;}

exp: lvalue {$$= A_VarExp(EM_tokPos,$1);}
   | voidexp {}
   | NIL {$$ = A_NilExp(EM_tokPos);}
   | 
   | exp AND exp {$$=A_IfExp(EM_tokPos,$1,$3,A_IntExp(EM_tokPos,0));}
   | exp OR exp {$$=A_IfExp(EM_tokPos,$1,A_IntExp(EM_tokPos,1),$3);} 

exps: exp {$$=A_Explist($1,NULL)}
   | exp SEMICOLON exps {$$=A_Explist($1,$3)}
   | {$$=NULL}

seqexp: exps {$$=A_SeqExp(EM_tokPos, $1);}   
	  
recorditem:ID EQ exp {$$=A_Efield(S_Symbol($1),$3);}

recorditems: recorditem {$$=A_EfiledList($1,NULL);}
    | recorditem COMMA recorditems {$$=A_EfiledList($1,$3);}
	| {$$=NULL}

voidexp: LET decs IN seqexp END {$$=A_LetExp(EM_tokPos, $2, $4);}
	| lvalue ASSIGN exp {$$=A_AssignExp(EM_tokPos, $1, $3);}
	| IF exp THEN exp {$$=A_IfExp(EM_tokPos, $2, $4, A_NilExp(EM_tokPos));}
	| IF exp THEN exp ELSE exp {$$=A_IfExp(EM_tokPos, $2, $4, $6);}
	| WHILE exp DO exp {$$=A_WhileExp(EM_tokPos, $2, $4);}
	| FOR ID ASSIGN exp TO exp DO exp {$$=A_ForExp(EM_tokPos, S_Symbol($2), $4, $6, $8);}
	| BREAK {$$=A_BreakExp(EM_tokPos);}

	   
args: 

tyfield: 
	
tyfields: 
	
ty: 
 
tydec:

tydecs: 

vardec: 

fundec: 
	
fundecs: 

dec: 

decs: 

lvalue: 
