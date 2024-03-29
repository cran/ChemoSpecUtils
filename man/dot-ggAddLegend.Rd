% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggAddLegend.R
\name{.ggAddLegend}
\alias{.ggAddLegend}
\title{Add Legend to a ggplot2 Plot}
\usage{
.ggAddLegend(spectra, use.sym, leg.loc)
}
\arguments{
\item{spectra}{An object of S3 class \code{\link[ChemoSpec:Spectra]{ChemoSpec::Spectra()}}.}

\item{use.sym}{Logical specifying if symbols will be used or not.}

\item{leg.loc}{A list giving x, y coordinates, and a reference point.}
}
\value{
A grob containing the legend.
}
\description{
\emph{Internal function}. This function creates a suitable legend and returns it as a set of grobs,
ready to be added to an existing plot.
}
\author{
Bryan A. Hanson (DePauw University), Tejasvi Gupta.
}
\keyword{internal}
