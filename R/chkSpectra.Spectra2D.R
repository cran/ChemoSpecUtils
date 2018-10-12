#'
#' @export
#' @noRd
#' 
chkSpectra.Spectra2D <- function(spectra, confirm = FALSE) {
	
	# Check classes/types of each element
	
	if (missing(spectra)) stop("No object of class Spectra2D provided")
	trouble <- FALSE
	extra <- FALSE
	if (!class(spectra) == "Spectra2D") {
		warning("The object provided was not of class Spectra2D")
		trouble <- TRUE }
	if (!class(spectra$F2) == "numeric") {
		warning("The F2 frequency data are not numeric")
		trouble <- TRUE }
	if (!class(spectra$F1) == "numeric") {
		warning("The F1 frequency data are not numeric")
		trouble <- TRUE }
	if (!class(spectra$data) == "list") {
		warning("Data is not a list")
		trouble <- TRUE }
	if (!class(spectra$names) == "character") {
		warning("The sample names are not character type")
		trouble <- TRUE }
	if (!class(spectra$units) == "character") {
		warning("The units are not character type")
		trouble <- TRUE }
	if (!class(spectra$desc) == "character") {
		warning("The description is not character type")
		trouble <- TRUE }
	if (!class(spectra$groups) == "factor") {
		warning("The assigned groups are not factor type")
		trouble <- TRUE }
	if (!class(spectra$colors) == "character") {
		warning("The assigned colors are not character type")
		trouble <- TRUE }
	
	# Check that F2 and F1 are sorted ascending

	if (is.unsorted(spectra$F2)) {warning("F2 frequency data are not sorted ascending"); trouble <- TRUE }
	if (is.unsorted(spectra$F1)) {warning("F1 frequency data are not sorted ascending"); trouble <- TRUE }

	# Check to make sure that every data matrix has the same dim & proper type
	
	ns <- length(spectra$names)
	dims <- matrix(NA_integer_, ncol = 2, nrow = ns)
	rownames(dims) <- spectra$names
	colnames(dims) <- c("F2", "F1")
	for (i in 1:ns) {
		if (!is.matrix(spectra$data[[i]])) stop("spectra$data entries should be matrices")
		if (!is.numeric(spectra$data[[i]])) stop("spectra$data entries should be numeric matrices")
		dims[i,] <- c(ncol(spectra$data[[i]]), nrow(spectra$data[[i]]))
	}
	
	Ucol1 <- length(unique(dims[,1])) == 1L # returns TRUE/FALSE
	Ucol2 <- length(unique(dims[,2])) == 1L
	
	if (!Ucol1 | !Ucol2) {
		message("Data matrices do not have the same dimensions.")
		print(dims)
	}
	
	# Check that data matrices have NAs in the same positions, if they have them at all
	
	M <- spectra$data # list of numeric matrices
	
	for (i in 1:ns) {
		M[[i]] <- is.na(spectra$data[[i]]) # now a list of logical matrices
	}
	
	for (i in 2:ns) {
		if (!identical(M[[i]], M[[i-1]])) stop("NAs are present in the data but differ between samples")
	}
		
	# Check that the relationships between each element are correct
		
	F2 <- length(spectra$F2)
	F1 <- length(spectra$F1)
	dd <- dim(spectra$data[[1]])
	g <- length(spectra$groups)
	nc <- length(spectra$colors)
	# note: ns was defined earlier as length(spectra$names)
	
	if (!identical(F1, dd[1])) { warning("Length(F1) != nrow(data)"); trouble <- TRUE }
	if (!identical(F2, dd[2])) { warning("Length(F2) != ncol(data)"); trouble <- TRUE }
	if (!identical(ns, g)) { warning("The dimensions don't make sense (names, group)"); trouble <- TRUE }
	if (!identical(ns, nc)) { warning("The dimensions don't make sense (names, colors)"); trouble <- TRUE }
	
	# Check for extra list elements and report

	extra <- .extraData(spectra)
	
	# Wrap up
	
	if ((!trouble) && (!extra) && (confirm)) message(">>> Everything looks good!")
	if (extra) message("\n\t>>>  Please check the extra data entries.")
	if (trouble) stop("\n>>>  Bummer: There seem to be one or more problems with this data set!")
	
	}
