% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/old_scheduleFork.R
\name{scheduleFork_old}
\alias{scheduleFork_old}
\title{Single sequential forks scheduler}
\usage{
scheduleFork_old(graph, overhead = 1000, bandwidth = 1.5e+09)
}
\arguments{
\item{graph}{object of class \code{TaskGraph} as returned from \code{\link{inferGraph}}
expression.}

\item{overhead}{numeric seconds to send any object}

\item{bandwidth}{numeric speed that the network can transfer an object
between processors in bytes per second. We don't take network
contention into account. This will have to be extended to account for
multiple machines.}
}
\value{
schedule object of class \code{ForkSchedule}
}
\description{
Single sequential forks scheduler
}
