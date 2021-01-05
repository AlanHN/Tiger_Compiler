#include <stdio.h>
#include "util.h"
#include "symbol.h"
#include "temp.h"
#include "tree.h"
#include "absyn.h"
#include "assem.h"
#include "frame.h"
#include "graph.h"
#include "flowgraph.h"
#include "liveness.h"
#include "table.h"

Live_moveList Live_MoveList(Live_move head, Live_moveList tail)
{
	Live_moveList lm = (Live_moveList)checked_malloc(sizeof(*lm));
	lm->head = head;
	lm->tail = tail;
	return lm;
}

Live_move Live_Move(G_node src, G_node dst)
{
	Live_move m = (Live_move)checked_malloc(sizeof(*m));
	m->src = src;
	m->dst = dst;
	return m;
}

Temp_temp Live_gtemp(G_node n)
{
	//your code here.
	return (Temp_temp)G_nodeInfo(n);
}

static void enterLiveMap(G_table t, G_node flowNode, Temp_tempList temps)
{
	G_enter(t,flowNode,temps);
}

static Live_moveList lookupLiveMap(G_table t, G_node flowNode)
{
	return (Live_moveList)G_look(t, flowNode);
}


// cost
static void enterCostMap(G_table t, G_node iNode, double d)
{
	double *p = G_look(t, iNode);
	if (!p)
	{
		p = checked_malloc(sizeof(double));
		G_enter(t, iNode, p);
	}
	*p = d;
}

static double lookupCostMap(G_table t, G_node iNode)
{
	double *p = G_look(t, iNode);
	if (p)
		return *p;
	return 0.0;
}

static void enterMoveMap(G_table t, G_node src, G_node dst)
{
	Live_moveList src_move = (Live_moveList)G_look(t, src);
	Live_moveList dst_move = (Live_moveList)G_look(t, dst);
	G_enter(t, src, Live_MoveList(Live_Move(src, dst), src_move));
	G_enter(t, dst, Live_MoveList(Live_Move(src, dst), dst_move));
}

static bool change = FALSE;
static Temp_tempList replace(Temp_tempList a, Temp_tempList b)
{
	// b >= a
	Temp_tempList d = Temp_tempDiff(b, a);
	if (d)
	{
		change = TRUE;
		return Temp_tempSplice(a, d);
	}
	else
	{
		return a;
	}
}

static G_table buildLiveMap(G_graph flow)
{
	G_table inTable = G_empty();
	G_table outTable = G_empty();

	G_nodeList rnodes = G_rnodes(flow);

	/*
	for each n
		in[n] <- use[n] U (out[n]-def[n])
		out[n] <- U in[s]
	*/
	change = FALSE;
	do
	{
		change = FALSE;
		for (G_nodeList nl = rnodes; nl; nl = nl->tail)
		{
			G_node node = nl->head;

			Temp_tempList in = (Temp_tempList)G_look(inTable, node);
			Temp_tempList out = (Temp_tempList)G_look(outTable, node);
			Temp_tempList use = FG_use(node);
			Temp_tempList def = FG_def(node);

			G_nodeList succ = G_succ(node);

			Temp_tempList new_in = Temp_tempUnion(use, Temp_tempDiff(out, def));
			Temp_tempList new_out = NULL;
			for (; succ; succ = succ->tail)
			{
				G_node s_node = succ->head;
				Temp_tempList s_in = (Temp_tempList)G_look(inTable, s_node);
				new_out = Temp_tempUnion(new_out, s_in);
			}

			in = replace(in, new_in);
			out = replace(out, new_out);

			G_enter(inTable, node, in);
			G_enter(outTable, node, out);
		}
	} while (change);
	return outTable;
}

struct Live_graph Live_liveness(G_graph flow)
{
	//your code here.
	struct Live_graph lg;

	// interferenceGraph
	G_graph graph = G_Graph();
	Live_moveList moves = NULL;
	G_table moveTable = G_empty();
	TAB_table nodeTable = TAB_empty();

	G_table liveTable = buildLiveMap(flow);
	G_table cost = G_empty();
	G_nodeList nodes = G_nodes(flow);

	//build nodeTable and add node to interferencegraph
	Temp_tempList added_temps = NULL;
	for (G_nodeList nl = nodes; nl != NULL; nl = nl->tail)
	{
		G_node node = nl->head;
		Temp_tempList def = FG_def(node);
		Temp_tempList use = FG_use(node);
		Temp_tempList add = Temp_tempUnion(def, use);//def U use
		for (Temp_tempList tl = add; tl; tl = tl->tail)
		{
			Temp_temp t = tl->head;
			if (!Temp_tempIn(added_temps, t))
			{
				TAB_enter(nodeTable, t, G_Node(graph, t));
				added_temps = Temp_TempList(t, added_temps);
			}
		}
	}

	//add edge to interferencegraph
	for (G_nodeList nl = nodes; nl; nl = nl->tail)
	{
		G_node node = nl->head;
		Temp_tempList def = FG_def(node);
		Temp_tempList out = (Temp_tempList)G_look(liveTable, node);
		Temp_tempList bs= out;

		// handle moves
		if (FG_isMove(node))
		{
			Temp_tempList use = FG_use(node);
			G_node src = (G_node)TAB_look(nodeTable, use->head);
			G_node dst = (G_node)TAB_look(nodeTable, def->head);
			moves = Live_MoveList(Live_Move(src, dst), moves);
			enterMoveMap(moveTable, src, dst);
			bs= Temp_tempDiff(out, use);
		}

		for (Temp_tempList tl = def; tl; tl = tl->tail)
		{
			Temp_temp a = tl->head;
			for (Temp_tempList tll = bs; tll; tll = tll->tail)
			{
				Temp_temp b = tll->head;
				if (a == b)
					continue;
				G_node td_node = (G_node)TAB_look(nodeTable, a);
				G_node tc_node = (G_node)TAB_look(nodeTable, b);
				G_addEdge(td_node, tc_node);
				G_addEdge(tc_node, td_node);
				enterCostMap(cost, td_node, lookupCostMap(cost, td_node) + 1);
				enterCostMap(cost, tc_node, lookupCostMap(cost, tc_node) + 1);
			}
		}
	}

	/* set cost */
	G_nodeList nl = G_nodes(graph);
	for (; nl; nl = nl->tail)
	{
		G_node n = nl->head;
		enterCostMap(cost, n, lookupCostMap(cost, n) / (G_degree(n) / 2));
	}

	lg.graph = graph;

	lg.moves = moves;
	lg.moveList = moveTable;

	lg.cost = cost;

	return lg;
}

bool Live_moveIn(Live_moveList ml, Live_move m)
{
	for (; ml; ml = ml->tail)
	{
		if (ml->head->src == m->src && ml->head->dst == m->dst)
		{
			return TRUE;
		}
	}
	return FALSE;
}

Live_moveList Live_moveRemove(Live_moveList ml, Live_move m)
{
	Live_moveList prev = NULL;
	Live_moveList origin = ml;
	for (; ml; ml = ml->tail)
	{
		if (ml->head->src == m->src && ml->head->dst == m->dst)
		{
			if (prev)
			{
				prev->tail = ml->tail;
				return origin;
			}
			else
			{
				return ml->tail;
			}
		}
		prev = ml;
	}
	return origin;
}

Live_moveList Live_moveDiff(Live_moveList in, Live_moveList notin)
{
	Live_moveList res = NULL;
	for (; in; in = in->tail)
	{
		if (!Live_moveIn(notin, in->head))
		{
			res = Live_MoveList(in->head, res);
		}
	}
	return res;
}

Live_moveList Live_moveUnion(Live_moveList a, Live_moveList b)
{
	Live_moveList ret = NULL;
	for (; a; a = a->tail)
	{
		if (!Live_moveIn(ret, a->head))
		{
			ret = Live_MoveList(a->head, ret);
		}
	}
	for (; b; b = b->tail)
	{
		if (!Live_moveIn(ret, b->head))
		{
			ret = Live_MoveList(b->head, ret);
		}
	}
	return ret;
}

Live_moveList Live_moveIntersect(Live_moveList a, Live_moveList b)
{
	Live_moveList res = NULL;
	for (; a; a = a->tail)
	{
		if (Live_moveIn(b, a->head))
		{
			res = Live_MoveList(a->head, res);
		}
	}
	return res;
}

Live_moveList Live_moveAppend(Live_moveList ml, Live_move m)
{
	if (Live_moveIn(ml, m))
	{
		return ml;
	}
	else
	{
		return Live_MoveList(m, ml);
	}
}
