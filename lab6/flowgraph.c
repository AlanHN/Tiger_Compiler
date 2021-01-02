#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "util.h"
#include "symbol.h"
#include "temp.h"
#include "tree.h"
#include "absyn.h"
#include "assem.h"
#include "frame.h"
#include "graph.h"
#include "flowgraph.h"
#include "errormsg.h"
#include "table.h"

Temp_tempList FG_def(G_node n)
{
	//your code here.
	AS_instr instr = (AS_instr)G_nodeInfo(n);
	switch (instr->kind)
	{
	case I_OPER:
	{
		return instr->u.OPER.dst;
	}
	case I_LABEL:
	{
		return NULL;
	}
	case I_MOVE:
	{
		return instr->u.MOVE.dst;
	}
	default:
	{
		assert(0);
		return NULL;
	}
	}
}

Temp_tempList FG_use(G_node n)
{
	//your code here.
	AS_instr instr = (AS_instr)G_nodeInfo(n);
	switch (instr->kind)
	{
	case I_OPER:
	{
		return instr->u.OPER.src;
	}
	case I_LABEL:
	{
		return NULL;
	}
	case I_MOVE:
	{
		return instr->u.MOVE.src;
	}
	default:
	{
		assert(0);
		return NULL;
	}
	}
}

bool FG_isMove(G_node n)
{
	//your code here.
	AS_instr instr = (AS_instr)G_nodeInfo(n);
	bool isMove = (instr->kind == I_MOVE);
	return isMove;
}

G_graph FG_AssemFlowGraph(AS_instrList il,F_frame f)
{
	//your code here.
	G_graph graph = G_Graph();
	TAB_table labelTable = TAB_empty();

	AS_instrList instrList = il;
	AS_instr instr = NULL;
	G_node fromNode = NULL;
	G_node toNode = NULL;
	for (; instrList != NULL; instrList = instrList->tail)
	{
		instr = instrList->head;
		toNode = G_Node(graph, (void *)instr);
		if (fromNode != NULL)
		{
			G_addEdge(fromNode, toNode);
		}

		fromNode = toNode;
		switch (instr->kind)
		{
		case I_OPER:
		{
			// ignore all jmp
			if (strncmp("\tjmp", instr->u.OPER.assem, 4) == 0)
			{
				fromNode = NULL;
			}
			break;
		}
		case I_LABEL:
		{
			TAB_enter(labelTable, instr->u.LABEL.label,toNode);
			break;
		}
		case I_MOVE:
		{
			break;
		}
		default:
		{
			assert(0);
			break;
		}
		}
	}

	//add jmp
	G_nodeList nodeList = G_nodes(graph);
	for (; nodeList != NULL; nodeList = nodeList->tail)
	{
	    fromNode = nodeList->head;
		instr = (AS_instr)G_nodeInfo(fromNode);

		if (instr->kind == I_OPER && instr->u.OPER.jumps != NULL)
		{
			Temp_labelList targets = instr->u.OPER.jumps->labels;
			for (; targets != NULL; targets = targets->tail)
			{
				toNode = (G_node)TAB_look(labelTable, targets->head);
				if (toNode)
				{
					G_addEdge(fromNode, toNode);
				}
			}
		}
	}
	return graph;
}
