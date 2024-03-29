% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checkForPackageWithVersion.R
\name{checkForPackageWithVersion}
\alias{checkForPackageWithVersion}
\title{Check for an Installed Package with a Particular Version or Newer}
\usage{
checkForPackageWithVersion(pkg, vers)
}
\arguments{
\item{pkg}{Character.  The name of the package to check.}

\item{vers}{Character. The minimum acceptable version of the package.  Will only be checked
to the major.minor level.}
}
\value{
If the package with the required version or higher is available, \code{TRUE} is returned
invisibly.  Otherwise \code{FALSE} is returned.
}
\description{
Utility function for making sure a package is available with a particular version or newer.
}
\author{
Bryan A. Hanson (DePauw University).
}
