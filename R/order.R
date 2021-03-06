#setMethod(sort, "TaskGraph", sortBottomLevel)


#' Order Nodes By Bottom Level Order
#'
#' Permute the nodes of the graph so that they are ordered in decreasing
#' bottom level precedence order. The bottom level of a node is the length
#' of the longest path starting at that node and going to the end of the
#' program.
#'
#' This permutation respects the partial order of the graph, so executing
#' the permuted code will produce the same result as the original code.
#' There are many possible node precedence orders. 
#'
#' @references \emph{Task Scheduling for Parallel Systems}, Sinnen, O.
#' claim bottom level order provides good average performance. I'm not sure
#' if this claim holds for general data analysis scripts.
#'
#' @export
#' @param graph \linkS4class{TimedTaskGraph}
#' @return integer vector to permute the expressions in \code{x@code}
#' @examples
#' graph <- inferGraph(code = parse(text = "x <- 1:100
#' y <- rep(1, 100)
#' z <- x + y"), time = c(1, 2, 1))
#' bl <- orderBottomLevel(graph)
orderBottomLevel = function(graph)
{
    bl = bottomLevel(graph)
    order(bl, decreasing = TRUE)
}


bottomLevel = function(graph)
{
    n = length(graph@code)
    alltimes = graph@time
    bl = rep(0, n)
    g = graph@graph
    # Iterating in reverse guarantees bl elements are defined for all
    # successors.
    for(node in seq(n, 1)){
        nodetime = alltimes[node]
        bl[node] = oneBottomLevel(node, nodetime, g, bl)
    }
    bl
}


oneBottomLevel = function(node, nodetime, graph, bl)
{
    s = successors(node, graph)
    if(length(s) == 0) nodetime else max(bl[s]) + nodetime
}
