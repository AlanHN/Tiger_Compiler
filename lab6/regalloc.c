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

struct RA_result RA_regAlloc(F_frame f, AS_instrList il) {
	//your code here
	struct RA_result ret;
	G_graph flowGraph;
	struct Live_graph liveGraph;
	struct COL_result colResult;

    bool done = TRUE;
	do{
		done = TRUE;
		flowGraph = FG_AssemFlowGraph(il);
		liveGraph = Live_liveness(flowGraph);
		// colResult = COL_color(liveGraph.graph,F_regTempMap(),F_registers(),liveGraph.moves);
		colResult = COL_color(liveGraph.graph,F_regTempMap(),F_registers(),liveGraph.moves,liveGraph.temp_to_moves,liveGraph.cost);
		if(colResult.spills!=NULL){
			il = AS_rewriteSpill(f,il,colResult.spills);
			done = FALSE;
		}
	}while(!done);

	AS_instrList nil = AS_rewrite(il, colResult.coloring);

	ret.coloring = colResult.coloring;
	ret.il = nil;

	return ret;
}
