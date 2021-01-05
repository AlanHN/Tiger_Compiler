#include <stdio.h>
#include <string.h>

#include "util.h"
#include "symbol.h"
#include "temp.h"
#include "tree.h"
#include "absyn.h"
#include "assem.h"
#include "frame.h"
#include "graph.h"
#include "liveness.h"
#include "color.h"
#include "table.h"

#include "limits.h"
#include <float.h>

#define INFINITE INT_MAX
static int K; // num of register

//node,worklist,nodes and stack
static Temp_tempList precolored; // mechine register
static Temp_tempList initial;	 // temp register

static G_nodeList simplifyWorklist;
static G_nodeList freezeWorklist;
static G_nodeList spillWorklist;
static G_nodeList spilledNodes;
static G_nodeList coalescedNodes;
static G_nodeList coloredNodes;
static G_nodeList selectStack;

//movelist
static Live_moveList coalescedMoves;
static Live_moveList constrainedMoves;
static Live_moveList frozenMoves;
static Live_moveList worklistMoves;
static Live_moveList activeMoves;

//other
static G_graph interferenceGraph; // the graph
static G_table degree;
static G_table moveList;
static G_table alias;
static G_table color;
static G_table spillCost;

bool isPrecolored(G_node n)
{
	return Temp_tempIn(precolored, Live_gtemp(n));
}

void initDegree()
{
	G_nodeList nodes = G_nodes(interferenceGraph);
	for (; nodes; nodes = nodes->tail)
	{
		G_node n = nodes->head;
		if (!isPrecolored(n))
		{
			G_enter(degree, n, (void *) (G_degree(n)/ 2));
		}
		else
		{
			G_enter(degree, n, (void *)INFINITE);
		}
	}
}

void init(G_graph ig, Temp_tempList regs, Live_moveList moves, G_table moveLists, G_table cost)
{
	K = F_regNum;
	precolored = regs;
	initial = NULL;
	simplifyWorklist = NULL;
	freezeWorklist = NULL;
	spillWorklist = NULL;
	spilledNodes = NULL;
	coalescedNodes = NULL;
	coloredNodes = NULL;
	selectStack = NULL;

	coalescedMoves = NULL;
	constrainedMoves = NULL;
	frozenMoves = NULL;
	worklistMoves = moves;
	activeMoves = NULL;

    interferenceGraph = ig;
    degree = G_empty();
	moveList = moveLists;
	alias = G_empty();
	color = G_empty();
	spillCost = cost;
	
	initDegree();
}

//---------------------------------

void addEdge(G_node u, G_node v)
{
	if (!G_goesTo(u, v)&&u!=v)
	{
		G_addEdge(u, v);
		G_addEdge(v, u);
		G_enter(degree, u, G_look(degree, u) + 1);
		G_enter(degree, v, G_look(degree, v) + 1);
	}
}

G_nodeList adjacent(G_node n)
{
	return G_nodeDiff(G_succ(n), G_nodeUnion(selectStack, coalescedNodes));
}

Live_moveList nodeMoves(G_node n)
{
	return Live_moveIntersect((Live_moveList)G_look(moveList, n), Live_moveUnion(activeMoves, worklistMoves));
}


bool moveRelated(G_node n)
{
	return nodeMoves(n) != NULL;
}

void makeWorkList()
{
	G_nodeList nodes = G_nodes(interferenceGraph);
	for (; nodes; nodes = nodes->tail)
	{
		
		G_node n = nodes->head;
		if (isPrecolored(n))
			continue;
		if ((int)G_look(degree, n) >= K)
		{
			spillWorklist = G_nodeAppend(spillWorklist, n);
		}
		else if (moveRelated(n))
		{
			freezeWorklist = G_nodeAppend(freezeWorklist, n);
		}
		else
		{
			simplifyWorklist = G_nodeAppend(simplifyWorklist, n);
		}
	}
}

//simplify

void enableMoves(G_nodeList nl)
{
	for (; nl; nl = nl->tail)
	{
		G_node n = nl->head;
		Live_moveList ml = nodeMoves(n);
		for (; ml; ml = ml->tail)
		{
			Live_move m = ml->head;
			if (Live_moveIn(activeMoves, m))
			{
				activeMoves = Live_moveRemove(activeMoves, m);
				worklistMoves = Live_moveAppend(worklistMoves, m);
			}
		}
	}
}

void decrementDegree(G_node m)
{
	int d = (int)G_look(degree, m);
	G_enter(degree, m, (void *)d - 1);
	if (d == K && !isPrecolored(m))
	{ 
		enableMoves(G_nodeAppend(adjacent(m), m));
		spillWorklist = G_nodeRemove(spillWorklist, m);
		if (moveRelated(m))
		{
			freezeWorklist = G_nodeAppend(freezeWorklist, m);
		}
		else
		{
			simplifyWorklist = G_nodeAppend(simplifyWorklist, m);
		}
	}
}

void simplify()
{
	G_node n = simplifyWorklist->head;
	simplifyWorklist = simplifyWorklist->tail;
	selectStack = G_nodeAppend(selectStack, n);
	G_nodeList nl = adjacent(n);
	for (; nl; nl = nl->tail)
	{
		G_node m = nl->head;
		decrementDegree(m);
	}
}

//coalesce

void addWorkList(G_node u)
{
	if (!isPrecolored(u) && !moveRelated(u) && ((int)G_look(degree, u) < K))
	{
		freezeWorklist = G_nodeDiff(freezeWorklist, G_NodeList(u,NULL));
		simplifyWorklist = G_nodeUnion(simplifyWorklist, G_NodeList(u,NULL));
	}
}

bool OK(G_node t, G_node v)
{
	return ((int)G_look(degree, t) < K) || isPrecolored(t) || G_goesTo(t, v);
}

// can coalesce?
bool conservative(G_nodeList nl)
{
	int k = 0;
	for (; nl; nl = nl->tail)
	{
		G_node node = nl->head;
		if ((int)G_look(degree, node) >= K)
		{
			k = k + 1;
		}
	}
	return k < K;
}

G_node getAlias(G_node n)
{
	if (G_nodeIn(coalescedNodes, n))
	{
		return getAlias((G_node)G_look(alias, n));
	}
	return n;
}

void combine(G_node u, G_node v)
{
	if (G_nodeIn(freezeWorklist, v))
	{
		freezeWorklist = G_nodeDiff(freezeWorklist, G_NodeList(v,NULL));
	}
	else
	{
		spillWorklist = G_nodeDiff(spillWorklist, G_NodeList(v,NULL));
	}

	coalescedNodes = G_nodeUnion(coalescedNodes, G_NodeList(v,NULL));
	G_enter(alias, v, u);
	Live_moveList uml = (Live_moveList)G_look(moveList, u);
	Live_moveList vml = (Live_moveList)G_look(moveList, v);
	G_enter(moveList, u, Live_moveUnion(uml, vml));
	enableMoves(G_NodeList(v, NULL));
	G_nodeList nl = adjacent(v);
	for (; nl; nl = nl->tail)
	{
		G_node t = nl->head;
		addEdge(t, u);
		decrementDegree(t);
	}
	if ((int)G_look(degree, u) >= K && G_nodeIn(freezeWorklist, u))
	{
		freezeWorklist = G_nodeDiff(freezeWorklist, G_NodeList(u,NULL));
		spillWorklist = G_nodeUnion(spillWorklist, G_NodeList(u,NULL));
	}
}

void coalesce()
{
	assert(worklistMoves != NULL);
	Live_move m = worklistMoves->head;

	G_node x = getAlias(m->src);
	G_node y = getAlias(m->dst);
	G_node u, v;
	if (isPrecolored(y))
	{
		u = y;
		v = x;
	}
	else
	{
		u = x;
		v = y;
	}
	worklistMoves = Live_moveRemove(worklistMoves, m);
	if (u == v)
	{
		coalescedMoves = Live_moveAppend(coalescedMoves, m);
		addWorkList(u);
	}
	else if (isPrecolored(v) || G_goesTo(u, v))
	{
		constrainedMoves = Live_moveAppend(constrainedMoves, m);
		addWorkList(u);
		addWorkList(v);
	}
	else
	{
		G_nodeList nl = adjacent(v);
		bool flag = TRUE;
		for (; nl; nl = nl->tail)
		{
			G_node t = nl->head;
			if (!OK(t, u))
			{
				flag = FALSE;
				break;
			}
		}

		if (isPrecolored(u) && flag || !isPrecolored(u) && conservative(G_nodeUnion(adjacent(u), adjacent(v))))
		{
			coalescedMoves = Live_moveAppend(coalescedMoves, m);
			combine(u, v);
			addWorkList(u);
		}
		else
		{
			activeMoves = Live_moveAppend(activeMoves, m);
		}
	}
}

//freeze

void freezeMoves(G_node u)
{
	Live_moveList ml = nodeMoves(u);
	for (; ml; ml = ml->tail)
	{
		Live_move m = ml->head;
		G_node x = m->src;
		G_node y = m->dst;
		G_node v;
		if (getAlias(y) == getAlias(u))
		{
			v = getAlias(x);
		}
		else
		{
			v = getAlias(y);
		}
		activeMoves = Live_moveRemove(activeMoves, m);
		frozenMoves = Live_moveAppend(frozenMoves, m);
		if (!nodeMoves(v) && (int)G_look(degree, v) < K)
		{
			freezeWorklist = G_nodeRemove(freezeWorklist, v);
			simplifyWorklist = G_nodeAppend(simplifyWorklist, v);
		}
	}
}

void freeze()
{
	G_node u = freezeWorklist->head;
	freezeWorklist = G_nodeRemove(freezeWorklist, u);
	simplifyWorklist = G_nodeAppend(simplifyWorklist, u);
	freezeMoves(u);
}

//select
void selectSpill()
{
	// find min
	double min = DBL_MAX;
	G_node minNode = NULL;
	for (G_nodeList nl = spillWorklist; nl; nl = nl->tail)
	{
		G_node n = nl->head;
		assert(!isPrecolored(n));
		double cost = *(double *)G_look(spillCost, n);;
		if (cost < min)
		{
			min = cost;
			minNode = n;
		}
	}

	spillWorklist = G_nodeRemove(spillWorklist, minNode);
	simplifyWorklist = G_nodeAppend(simplifyWorklist, minNode);
	freezeMoves(minNode);
}

void assignColors()
{
	for (G_nodeList nl = G_nodes(interferenceGraph); nl; nl = nl->tail)
	{
		G_node n = nl->head;
		if (isPrecolored(n))
		{
			G_enter(color, n, Live_gtemp(n));
			coloredNodes = G_nodeAppend(coloredNodes, n);
		}
	}
	while (selectStack)
	{
		G_node n = selectStack->head;
		selectStack = selectStack->tail;
	
		if (G_nodeIn(coloredNodes, n))
			continue;
		Temp_tempList okColors = precolored;
		G_nodeList adj = G_adj(n);
		for (; adj; adj = adj->tail)
		{
			G_node w = adj->head;
			if (G_nodeIn(coloredNodes, getAlias(w)) || isPrecolored(getAlias(w)))
			{
				okColors = Temp_tempDiff(okColors, Temp_TempList((Temp_temp)G_look(color, (getAlias(w))), NULL));
			}
		}
		if (!okColors)
		{
			spilledNodes = G_nodeAppend(spilledNodes, n);
		}
		else
		{
			coloredNodes = G_nodeAppend(coloredNodes, n);
			G_enter(color, n, okColors->head);
		}
	}
	G_nodeList nl = coalescedNodes;
	for (; nl; nl = nl->tail)
	{
		G_node n = nl->head;
		G_enter(color, n, (Temp_temp)G_look(color, (getAlias(n))));
	}
}
//main
struct COL_result COL_color(G_graph ig, Temp_map initial, Temp_tempList regs, Live_moveList moves, G_table moveLists, G_table cost)
{
	struct COL_result ret;

	init(ig, regs, moves, moveLists, cost);
	makeWorkList();

	// assign colors
	do
	{
		if (simplifyWorklist)
		{
			simplify();
		}
		else if (worklistMoves)
		{
			coalesce();
		}
		else if (freezeWorklist)
		{
			freeze();
		}
		else if (spillWorklist)
		{
			selectSpill();
		}
	} while (simplifyWorklist || worklistMoves || freezeWorklist || spillWorklist);
	assignColors();

	ret.spills = NULL;
	ret.coloring = NULL;

	// spilled, get spills
	if (spilledNodes)
	{
		Temp_tempList spills = NULL;
		for (G_nodeList nl = spilledNodes; nl; nl = nl->tail)
		{
			G_node n = nl->head;
			spills = Temp_TempList(Live_gtemp(n), spills);
		}
		ret.spills = spills;
	}
	// no spilled, color it
	else
	{
		Temp_map coloring = Temp_empty();
		G_nodeList nl = G_nodes(interferenceGraph);
		for (; nl; nl = nl->tail)
		{
			G_node n = nl->head;
			Temp_temp colorr = (Temp_temp)G_look(color, n);
			if (colorr)
			{
				Temp_enter(coloring, Live_gtemp(n), Temp_look(initial, colorr));
			}
		}
		ret.coloring = Temp_layerMap(coloring, initial);
	}

	return ret;
}
