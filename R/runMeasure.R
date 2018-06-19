#' Run and Measure Code
#'
#' Run the serial code in the task graph and measure how long each expression
#' takes to run as well as the object sizes of each variable that can
#' possibly be transferred.
#'
#' This does naive and biased timing since it doesn't account for the
#' overhead in evaluating a single expression. However, this is fine in
#' this application since the focus is on measuring statements that take at
#' least 1 second to run. 
#'
#' @export
#' @param code to be passed into \code{\link{inferGraph}}
#' @param graph object of class \code{DependGraph}
#' @param envir environment to evaluate the code in
#' @param timer function that returns a timestamp.
#' @return 
runMeasure = function(code, graph = inferGraph(code), envir = globalenv(), timer = Sys.time)
{
    expr = graph@code
    n = length(expr)
    times = numeric(n)
    tg = graph@graph

    # Eliminate as much overhead for the timing as possible.
    force(envir)

    for(i in seq(n)){
        gc()
        start_time = timer()
        eval(expr[[i]], envir)
        end_time = timer()
        times[i] = end_time - start_time

        from_rows = tg$type == "use-def" & tg$from == i
        vars_to_measure = tg[from_rows, "value"]
        for(v in vars_to_measure){
            size = as.numeric(object.size(get(v, envir)))
            tg[from_rows & tg$value == v, "size"] = size
        }
    }

    new("MeasuredDependGraph", code = expr, graph = tg, time = times)
}