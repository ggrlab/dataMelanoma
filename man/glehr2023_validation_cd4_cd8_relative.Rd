% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_glehr2023.R
\docType{data}
\name{glehr2023_validation_cd4_cd8_relative}
\alias{glehr2023_validation_cd4_cd8_relative}
\title{Glehr 2023}
\format{
An object of class \code{tbl_df} (inherits from \code{tbl}, \code{data.frame}) with 41 rows and 89 columns.
}
\usage{
glehr2023_validation_cd4_cd8_relative
}
\description{
A training set of 110 patients and a validation set of 41 samples with advanced
melanoma. Note that some samples were measured in duplicates. Whole blood was
collected from healthy thrombocyte donors. Blood samples were obtained from patients
with Stage III/IV melanoma. Samples were measured with flow cytometry, recompensated,
arcsinh-transformed and rescaled before applying a uniform gating strategy. This data
then shows clinical information, the cell counts per gated population in 10,000 cells
(pheno_pops_10k) and their frequencies relative to the CD4+ or CD8+ cells
(cd4_cd8_relative). As convenience, unique_validation_cd4_cd8_relative are the
relative frequencies for validation samples measured only on the Navios cytometer
and not on the Navios EX cytometer.
}
\keyword{datasets}
