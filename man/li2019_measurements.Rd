% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_li2019.R
\docType{data}
\name{li2019_measurements}
\alias{li2019_measurements}
\title{Li 2019 measurements}
\format{
A list of 4 of "s1", "s2", "s3_nivo" and "s3_ever". Inside, a list of tibbles with
measurements for each timepoint. The names of the inside-list corresponds to the
timepoint ("baseline", "week 4", "week 6" or "week 8").
}
\source{
Liu, D., Schilling, B., Liu, D. et al. Integrative molecular and clinical modeling of
clinical outcomes to PD1 blockade in patients with metastatic melanoma.
Nat Med 25, 1916–1927 (2019). https://doi.org/10.1038/s41591-019-0654-5
}
\usage{
li2019_measurements
}
\description{
Samples in the studies were measured at baseline and at weeks 4, 6 and 8. Not all
samples were measured at all timepoints. The measurements are stored in a list
with 4 elements, one for each study. Each element is a list a tibble for each timepoint.

Each tibble starts with a column \code{Unique_Subject_Identifier} that identifies
the sample. The remaining columns are the measurements.
}
\keyword{datasets}
