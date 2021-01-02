#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "symbol.h"
#include "absyn.h"
#include "temp.h"
#include "errormsg.h"
#include "tree.h"
#include "assem.h"
#include "frame.h"
#include "codegen.h"
#include "table.h"
#include "string.h"

//Lab 6: put your code here
static AS_instrList iList = NULL, last = NULL;
static void emit(AS_instr inst)
{
    if (last != NULL)
    {
        last = last->tail = AS_InstrList(inst, NULL);
    }
    else
    {
        last = iList = AS_InstrList(inst, NULL);
    }
}

static Temp_temp munchExp(T_exp e);
static void munchStm(T_stm s);
static Temp_tempList munchArgs(int i, T_expList args, int *stack_size);

AS_instrList F_codegen(F_frame f, T_stmList stmList)
{
    T_stmList s1 = stmList;

    for (; s1 != NULL; s1 = s1->tail)
    {
        munchStm(s1->head);
    }

    AS_instrList list = iList;
    iList = last = NULL;

     return F_procEntryExit2(list);
}

static Temp_tempList L(Temp_temp h, Temp_tempList t) { return Temp_TempList(h, t); }

// maximal munch
static Temp_temp munchExp(T_exp e)
{
    char buf[100];
    switch (e->kind)
    {
    case T_BINOP:
    {
        Temp_temp ret = Temp_newtemp();
        Temp_temp left = munchExp(e->u.BINOP.left);
        Temp_temp right = munchExp(e->u.BINOP.right);
        switch (e->u.BINOP.op)
        {
        case T_plus:
        {
            // mov left ret
            emit(AS_Move("\tmovq `s0, `d0", Temp_TempList(ret, NULL), Temp_TempList(left, NULL)));
            // add right(ret) ret
            emit(AS_Oper("\taddq `s0, `d0", Temp_TempList(ret, NULL), Temp_TempList(right, Temp_TempList(ret, NULL)), NULL));
            break;
        }
        case T_minus:
        {
            // mov left ret
            emit(AS_Move("\tmovq `s0, `d0", Temp_TempList(ret, NULL), Temp_TempList(left, NULL)));
            // sub right(ret) ret
            emit(AS_Oper("\tsubq `s0, `d0", Temp_TempList(ret, NULL), Temp_TempList(right, Temp_TempList(ret, NULL)), NULL));
            break;
        }
        case T_mul:
        {
            emit(AS_Move("\tmovq `s0, `d0", F_MUL(), Temp_TempList(left, NULL)));
            emit(AS_Oper("\timulq `s0, `d0", F_MUL(), Temp_TempList(right, F_MUL()), NULL));
            emit(AS_Move("\tmovq `s0, `d0", Temp_TempList(ret, NULL), F_MUL()));
            break;
        }
        case T_div:
        {
            emit(AS_Move("\tmovq `s0, `d0", F_DIV(), Temp_TempList(left, NULL)));
            emit(AS_Oper("\tcltd", F_DIV(), F_DIV(), NULL));
            emit(AS_Oper("\tidivq `s0", F_DIV(), Temp_TempList(right, F_DIV()), NULL));
            emit(AS_Move("\tmovq `s0, `d0", Temp_TempList(ret, NULL), F_DIV()));
            break;
        }
        default:
        {
            assert(0);
            break;
        }
        }
        return ret;
    }
    case T_MEM:
    {
        Temp_temp ret = Temp_newtemp();
        T_exp mem = e->u.MEM;
        switch (e->kind)
        {
        case T_CONST:
        {
            sprintf(buf, "\tmovq %d, `d0", mem->u.CONST);
            emit(AS_Oper(String(buf), Temp_TempList(ret, NULL), NULL, NULL));
            break;
        }
        case T_BINOP:
        {
            if (mem->u.BINOP.op == T_plus)
            {
                if (mem->u.BINOP.right->kind == T_CONST)
                {
                    Temp_temp b = munchExp(mem->u.BINOP.left);
                    sprintf(buf, "\tmovq %d(`s0), `d0", mem->u.BINOP.right->u.CONST);
                    emit(AS_Oper(String(buf), Temp_TempList(ret, NULL), Temp_TempList(b, NULL), NULL));
                }
                // record or array
                else if (mem->u.BINOP.right->kind == T_BINOP && mem->u.BINOP.right->u.BINOP.op == T_mul &&
                         mem->u.BINOP.right->u.BINOP.right->kind == T_CONST && mem->u.BINOP.right->u.BINOP.right->u.CONST == F_wordSize)
                {
                    Temp_temp b = munchExp(mem->u.BINOP.left);
                    Temp_temp i = munchExp(mem->u.BINOP.right->u.BINOP.left);
                    sprintf(buf, "\tmovq (`s0,`s1,%d), `d0", F_wordSize);
                    emit(AS_Oper(String(buf), Temp_TempList(ret, NULL), Temp_TempList(b, Temp_TempList(i, NULL)), NULL));
                }
            }
            else
            {
                //MEM only add
                assert(0);
            }
            break;
        }
        default:
        {
            Temp_temp s = munchExp(mem);
            emit(AS_Oper("\tmovq (`s0), `d0", Temp_TempList(ret, NULL), Temp_TempList(s, NULL), NULL));
            break;
        }
        }
        return ret;
    }
    case T_TEMP:
    {
        return e->u.TEMP;
    }
    case T_ESEQ:
    {
        munchStm(e->u.ESEQ.stm);
        return munchExp(e->u.ESEQ.exp);
    }
    case T_NAME:
    {
        Temp_temp ret = Temp_newtemp();
        sprintf(buf, "\tleaq .%s(%rip), `d0", Temp_labelstring(e->u.NAME));
        emit(AS_Oper(String(buf), Temp_TempList(ret, NULL), NULL, NULL));
        return ret;
    }
    case T_CONST:
    {
        Temp_temp ret = Temp_newtemp();
        sprintf(buf, "\tmovq $%d, `d0", e->u.CONST);
        emit(AS_Oper(String(buf), Temp_TempList(ret, NULL), NULL, NULL));
        return ret;
    }
    case T_CALL:
    {
        Temp_temp ret = F_RV();
        int stack_size = 0;
        // args
        Temp_tempList l = munchArgs(0, e->u.CALL.args, &stack_size);

        // call
        sprintf(buf, "\tcall %s", Temp_labelstring(e->u.CALL.fun->u.NAME));
        emit(AS_Oper(String(buf), Temp_TempList(F_RV(), F_callerSaves()), l, NULL));

        // adjust stack
        if (stack_size > 0)
        {
            memset(buf, 0, sizeof(buf));
            sprintf(buf, "\taddq $%d, `d0", stack_size);
            emit(AS_Oper(String(buf), Temp_TempList(F_SP(), NULL), NULL, NULL));
        }
        return ret;
    }
    default:
        assert(0);
        break;
    }
}

static void munchStm(T_stm s)
{
    char buf[100];
    switch (s->kind)
    {
    case T_SEQ:
    {
        munchStm(s->u.SEQ.left);
        munchStm(s->u.SEQ.right);
        break;
    }
    case T_LABEL:
    {
        sprintf(buf, ".%s", Temp_labelstring(s->u.LABEL));
        emit(AS_Label(String(buf), s->u.LABEL));
        break;
    }
    case T_JUMP:
    {
        emit(AS_Oper("\tjmp .`j0", NULL, NULL, AS_Targets(s->u.JUMP.jumps)));
        break;
    }
    case T_CJUMP:
    {
        Temp_temp left = munchExp(s->u.CJUMP.left);
        Temp_temp right = munchExp(s->u.CJUMP.right);
        emit(AS_Oper("\tcmp `s1, `s0", NULL, Temp_TempList(left, Temp_TempList(right, NULL)), NULL));
        char *op;
        switch (s->u.CJUMP.op)
        {
        case T_eq:
        {
            op = "je";
            break;
        }
        case T_ne:
        {
            op = "jne";
            break;
        }
        case T_lt:
        {
            op = "jl";
            break;
        }
        case T_gt:
        {
            op = "jg";
            break;
        }
        case T_le:
        {
            op = "jle";
            break;
        }
        case T_ge:
        {
            op = "jge";
            break;
        }
        }
        sprintf(buf, "\t%s .`j0", op);
        emit(AS_Oper(String(buf), NULL, NULL, AS_Targets(Temp_LabelList(s->u.CJUMP.true, NULL))));
        break;
    }
    case T_MOVE:
    {
        T_exp dst = s->u.MOVE.dst;
        T_exp src = s->u.MOVE.src;  
        Temp_temp t = munchExp(src);
        switch (dst->kind)
        {
        case T_MEM:
        {
            T_exp mem = dst->u.MEM;
            if (mem->kind == T_BINOP)
            {
                if (mem->u.BINOP.op == T_plus)
                {
                    // M[const]
                    if (mem->u.BINOP.right->kind == T_CONST)
                    {
                        Temp_temp b = munchExp(mem->u.BINOP.left);
                        sprintf(buf, "\tmovq `s0, %d(`s1)", mem->u.BINOP.right->u.CONST);
                        emit(AS_Oper(String(buf), NULL, Temp_TempList(t, Temp_TempList(b, NULL)), NULL));
                        break;
                    }
                    // M[rb,ri,s]
                    else if (mem->u.BINOP.right->kind == T_BINOP && mem->u.BINOP.right->u.BINOP.op == T_mul && mem->u.BINOP.right->u.BINOP.right->kind == T_CONST && mem->u.BINOP.right->u.BINOP.right->u.CONST == F_wordSize)
                    {
                        Temp_temp b = munchExp(mem->u.BINOP.left);
                        Temp_temp i = munchExp(mem->u.BINOP.right->u.BINOP.left);
                        sprintf(buf, "\tmovq `s0, (`s1,`s2,%d)", F_wordSize);
                        emit(AS_Oper(String(buf), NULL, Temp_TempList(t, Temp_TempList(b, Temp_TempList(i, NULL))), NULL));
                        break;
                    }
                }
            }
            Temp_temp d = munchExp(mem);
            emit(AS_Oper("\tmovq `s0, (`s1)", NULL, Temp_TempList(t, Temp_TempList(d, NULL)), NULL));
            break;
        }
        case T_TEMP:
        {
            Temp_temp d = munchExp(dst);
            emit(AS_Move("\tmovq `s0, `d0", Temp_TempList(d, NULL), Temp_TempList(t, NULL)));
            break;
        }
        default:
        {
            assert(0);
            break;
        }
            
        }
        break;
    }
    case T_EXP:
    {
        munchExp(s->u.EXP);
        break;
    }
    default:
        //assert(0);
        break;
    }
}

static Temp_tempList munchArgs(int i, T_expList args, int *stack_size)
{
    if (!args)
    {
        return NULL;
    }
    else
    {
        Temp_tempList recur = munchArgs(i + 1, args->tail, stack_size);
        Temp_temp cur = munchExp(args->head);
        Temp_temp arg = NULL;
        // push to stack
        if (i >= F_formalRegNum)
        {
            emit(AS_Oper("\tpushq `s0", Temp_TempList(F_SP(), NULL), Temp_TempList(cur, Temp_TempList(F_SP(), NULL)), NULL));
            *stack_size += F_wordSize;
        }
        else
        {
            Temp_tempList argRegs = F_paramReg();
            for (int j = 0; j < i; j++)
            {
                argRegs = argRegs->tail;
            }
            arg = argRegs->head;
            emit(AS_Move("\tmovq `s0, `d0", Temp_TempList(arg, NULL), Temp_TempList(cur, NULL)));
        }
        if (arg)
        {
            return Temp_TempList(arg, recur);
        }
        else
        {
            return recur;
        }
    }
}