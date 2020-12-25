// #include <stdio.h>
// #include <string.h>
// #include <stdlib.h>

// #include "util.h"
// #include "symbol.h"
// #include "temp.h"
// #include "tree.h"
// #include "absyn.h"
// #include "assem.h"
// #include "frame.h"
// #include "graph.h"
// #include "flowgraph.h"
// #include "errormsg.h"
// #include "table.h"

// Temp_tempList FG_def(G_node n) {
// 	AS_instr inst = (AS_instr)G_nodeInfo(n);
// 	if (inst->kind == I_OPER) {
// 		return inst->u.OPER.dst;
// 	} else if (inst->kind == I_MOVE) {
// 		return inst->u.MOVE.dst;
// 	}
// 	return NULL;
// }

// Temp_tempList FG_use(G_node n) {
// 	AS_instr inst = (AS_instr)G_nodeInfo(n);
// 	if (inst->kind == I_OPER) {
// 		return inst->u.OPER.src;
// 	} else if (inst->kind == I_MOVE) {
// 		return inst->u.MOVE.src;
// 	}
// 	return NULL;
// }

// bool FG_isMove(G_node n) {
// 	AS_instr inst = (AS_instr)G_nodeInfo(n);
// 	return inst->kind == I_MOVE;
// }

// G_graph FG_AssemFlowGraph(AS_instrList il) {
// 	G_graph g = G_Graph();
// 	TAB_table t = TAB_empty();

// 	G_node prev = NULL;

// 	for (AS_instrList i = il; i; i=i->tail) {
// 		AS_instr inst = i->head;
// 		G_node node = G_Node(g, (void *)inst);
// 		if (prev) {
// 			G_addEdge(prev, node);
// 		}
// 		if (inst->kind == I_OPER && strncmp("\tjmp", inst->u.OPER.assem, 4) == 0) {
// 			prev = NULL;
// 		} else {
// 			prev = node;
// 		}
// 		if (inst->kind == I_LABEL) {
// 			TAB_enter(t, inst->u.LABEL.label, node);
// 		}
// 	}

// 	//add jump targets
// 	G_nodeList nl = G_nodes(g);
// 	for (; nl; nl=nl->tail) {
// 		G_node node = nl->head;
// 		AS_instr inst = (AS_instr)G_nodeInfo(node);

// 		if (inst->kind == I_OPER && inst->u.OPER.jumps) {
// 			Temp_labelList targets = inst->u.OPER.jumps->labels;
// 			for (; targets; targets=targets->tail) {
// 				G_node t_node = (G_node)TAB_look(t, targets->head);
// 				if (t_node) {
// 					G_addEdge(node, t_node);
// 				}
// 			}
// 		}
// 	}

// 	return g;
// }
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

G_graph FG_AssemFlowGraph(AS_instrList il)
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
