#'
#' chkSpectra.Spectra
#'
#' @author `r .writeDoc_Authors("BH")`
#' @export
#' @noRd
#'
#'
chkSpectra.Spectra <- function(spectra, confirm = FALSE) {

  # Many kinds of errors may be missed due to coercion:
  # e.g. spectra$colors[22] <- 1.2 creates "1.2" as the entry
  # Only complete replacement of $colors with all integers throws an error.

  trouble <- FALSE
  extra <- FALSE

  # Check classes/types

  if (!inherits(spectra, "Spectra")) {
    warning("The object provided was not a Spectra object")
    trouble <- TRUE
  }
  if (!inherits(spectra$freq, "numeric")) {
    warning("class(freq) is not numeric")
    trouble <- TRUE
  }
  if (!inherits(spectra$data, "matrix")) {
    warning("class(data) is not matrix")
    trouble <- TRUE
  }
  if (!inherits(spectra$names, "character")) {
    warning("class(names) is not character")
    trouble <- TRUE
  }
  if (!inherits(spectra$colors, "character")) {
    warning("class(colors) is not character")
    trouble <- TRUE
  }
  if (!((inherits(spectra$unit, "character")) | (is.expression(spectra$unit)))) {
    warning("class(unit) is not character or expression")
    trouble <- TRUE
  }
  if (!inherits(spectra$desc, "character")) {
    warning("class(desc) is not character")
    trouble <- TRUE
  }
  if (!inherits(spectra$groups, "factor")) {
    warning("class(groups) is not factor")
    trouble <- TRUE
  }

  # Check dimensions & relationships

  f <- length(spectra$freq)
  d2 <- dim(spectra$data)[2]
  n <- length(spectra$names)
  g <- length(spectra$groups)
  co <- length(spectra$colors)
  d1 <- dim(spectra$data)[1]
  sy <- length(spectra$sym)
  ay <- length(spectra$alt.sym)

  if (!identical(f, d2)) {
    warning("The dimensions don't make sense (freq, data)")
    trouble <- TRUE
  }
  if (!identical(n, g)) {
    warning("The dimensions don't make sense (names, group)")
    trouble <- TRUE
  }
  if (!identical(g, co)) {
    warning("The dimensions don't make sense (group, colors)")
    trouble <- TRUE
  }
  if (!identical(co, d1)) {
    warning("The dimensions don't make sense (colors, data)")
    trouble <- TRUE
  }
  if (!identical(co, sy)) {
    warning("The dimensions don't make sense (colors, symbols)")
    trouble <- TRUE
  }
  if (!identical(sy, ay)) {
    warning("The dimensions don't make sense (symbols, alt symbols)")
    trouble <- TRUE
  }

  # Check for NA's in the data (saves some grief and questions later)

  for (i in 1:nrow(spectra$data)) {
    prob <- which(is.na(spectra$data[i, ]))
    if (length(prob) > 1L) {
      msg <- paste("NA found in data for", spectra$names[i], ", please inspect/repair")
      message(msg)
      trouble <- TRUE
    }
  }

  # Check for duplicates sample names

  dup <- anyDuplicated(spectra$names)
  if (dup != 0L) {
    message("Duplicate sample names found, please inspect/repair")
    trouble <- TRUE
  }

  # Check for extra list elements and report

  extra <- .extraData(spectra)

  # Wrap up

  if ((!trouble) && (!extra) && (confirm)) message(">>> Everything looks good!")
  if (extra) message("\n\t>>>  Please check the extra data entries.")
  if (trouble) stop("\n>>>  Bummer: There seem to be one or more problems with this data set!")
}

