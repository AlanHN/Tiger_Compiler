#include <stdio.h>
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
#include "regalloc.h"
#include "table.h"
#include "flowgraph.h"

struct COL_result colResult;

static void Main(F_frame f, AS_instrList il)
{
	G_graph flowGraph = FG_AssemFlowGraph(il, f);
	struct Live_graph liveGraph = Live_liveness(flowGraph);
	//Build --AssignColor
	colResult = COL_color(liveGraph.graph, F_tempMapInit(), F_registers(), liveGraph.moves, liveGraph.moveList, liveGraph.cost);
	if (colResult.spills != NULL)
	{
		il = AS_rewriteSpill(f, il, colResult.spills);
		Main(f,il);
	}
}
struct RA_result RA_regAlloc(F_frame f, AS_instrList il) {
	//your code here
	struct RA_result ret;

	Main(f,il);

	AS_instrList rewrite = AS_rewrite(il, colResult.coloring);

	ret.coloring = colResult.coloring;
	ret.il = rewrite;

	return ret;
}
