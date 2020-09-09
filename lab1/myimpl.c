#include "prog1.h"
#include <stdio.h>
#include <string.h>

int maxargs(A_stm stm)
{
	int ret = 0;
	switch (stm->kind)
	{
	case A_compoundStm:
	{
		int stm1 = maxargs(stm->u.compound.stm1);
		int stm2 = maxargs(stm->u.compound.stm2);
		ret = stm1 > stm2 ? stm1 : stm2;
		break;
	}
	case A_assignStm:
	{
		switch (stm->u.assign.exp->kind)
		{
		case A_eseqExp:
		{
			ret = maxargs(stm->u.assign.exp->u.eseq.stm);
			break;
		}
		default:
		{
			ret = 0;
			break;
		}
		}
		break;
	}
	case A_printStm:
	{
		A_expList expList = stm->u.print.exps;
		A_expList exp = expList;
		int num = 1;
		int innermax = 0;
		while (exp->kind != A_lastExpList)
		{
			num++;
			if (exp->u.pair.head->kind == A_eseqExp)
			{
				int inner = maxargs(exp->u.pair.head->u.eseq.stm);
				innermax = innermax > inner ? innermax : inner;
			}
			exp = exp->u.pair.tail;
		}
		if (exp->u.last->kind == A_eseqExp)
		{
			int inner = maxargs(exp->u.last->u.eseq.stm);
			innermax = innermax > inner ? innermax : inner;
		}
		ret = num > innermax ? num : innermax;
		break;
	}
	default:
		break;
	}
	return ret;
}

typedef struct table *Table_;
struct table
{
	string id;
	int value;
	Table_ tail;
};
Table_ Table(string id, int value, Table_ tail)
{
	Table_ t = checked_malloc(sizeof(*t));
	t->id = id;
	t->value = value;
	t->tail = tail;
	return t;
}

typedef struct intAndTable *IntAndTable_;
struct intAndTable
{
	int i;
	Table_ t;
};
IntAndTable_ IntAndTable(int i, Table_ t)
{
	IntAndTable_ iAndt = checked_malloc(sizeof(*iAndt));
	iAndt->i = i;
	iAndt->t = t;
	return iAndt;
}

Table_ interpStm(A_stm s, Table_ t);
IntAndTable_ interpExp(A_exp e, Table_ t);

int lookup(Table_ t, string key)
{
	Table_ exp = t;
	while (exp != NULL)
	{
		if (!strcmp(exp->id, key))
		{
			return exp->value;
		}
		exp = exp->tail;
	}
}

Table_ interpStm(A_stm s, Table_ t)
{
	Table_ ret = NULL;
	switch (s->kind)
	{
	case A_compoundStm:
	{
		Table_ t1 = interpStm(s->u.compound.stm1, t);
		ret = interpStm(s->u.compound.stm2, t1);
		break;
	}
	case A_assignStm:
	{
		IntAndTable_ iAndt = interpExp(s->u.assign.exp, t);
		ret = Table(s->u.assign.id, iAndt->i, iAndt->t);
		break;
	}
	case A_printStm:
	{
		A_expList expList = s->u.print.exps;
		A_expList exp = expList;
		Table_ t1 = t;
		while (exp->kind != A_lastExpList)
		{
			IntAndTable_ iAndt = interpExp(expList->u.pair.head, t1);
			t1 = iAndt->t;
			printf("%d", iAndt->i);
			exp = exp->u.pair.tail;
		}
		IntAndTable_ iAndt = interpExp(exp->u.last, t1);
		t1 = iAndt->t;
		printf("%d\n", iAndt->i);
		ret = t1;
		break;
	}
	default:
		break;
	}
	return ret;
}

IntAndTable_ interpExp(A_exp e, Table_ t)
{
	IntAndTable_ ret = NULL;
	switch (e->kind)
	{
	case A_idExp:
	{
		ret = IntAndTable(lookup(t, e->u.id), t);
		break;
	}
	case A_numExp:
	{
		ret = IntAndTable(e->u.num, t);
		break;
	}
	case A_opExp:
	{
		IntAndTable_ left = interpExp(e->u.op.left, t);
		IntAndTable_ right = interpExp(e->u.op.right, left->t);
		int result = 0;
		switch (e->u.op.oper)
		{
		case A_plus:
			result = left->i + right->i;
			break;
		case A_minus:
			result = left->i - right->i;
			break;
		case A_times:
			result = left->i * right->i;
			break;
		case A_div:
			result = left->i / right->i;
			break;
		default:
			break;
		}
		ret = IntAndTable(result, right->t);
		break;
	}
	case A_eseqExp:
	{
		Table_ t1 = interpStm(e->u.eseq.stm, t);
		ret = interpExp(e->u.eseq.exp, t1);
		break;
	}
	default:
		break;
	}
	return ret;
};

void interp(A_stm stm)
{
	Table_ t = NULL;
	interpStm(stm, t);
}
