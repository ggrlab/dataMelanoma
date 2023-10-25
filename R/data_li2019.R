#' @title Li 2019 phenodata
#' @description List of phenodata per study. There are 3 studies with 4 branches:
#' \describe{
#'      \item{s1} {melanoma (nivolumab, phase1)}
#'      \item{s2} {RCC (nivolumab, phase1)}
#'      \item{s3_nivo} {RCC (nivolumab, phase3)}
#'      \item{s3_ever} {RCC (everolimus, phase3)}
#' }
#' Each of the four list elements contains a data frame with samples as rows and
#' pheno-information as columns.
#' @format A list of 4 with a single tibble each.
#' \describe{
#'      \item{s1} {78 samples, 8 columns}
#'      \item{s2} {91 samples, 8 columns}
#'      \item{s3_nivo} {394 samples, 10 columns}
#'      \item{s3_ever} {349 samples, 10 columns}
#' }
#'
#' The data.frames ``s1`` and ``s2`` have the following columns:
#' \describe{
#'   \item{\code{Unique_Subject_Identifier}}{Identifier}
#'   \item{\code{Region}}{Sample region}
#'   \item{\code{Derived_Age_at_Consent}}{Age at consent}
#'   \item{\code{Sex}}{Sex. "M", "F". }
#'   \item{\code{Race}}{"WHITE" or "OTHER"}
#'   \item{\code{BRAF_V600E}}{BRAF_V600E mutation status}
#'   \item{\code{OS}}{Overall survival time}
#'   \item{\code{OS_Censor}}{Overall survival status}
#' }
#'
#' The data.frames ``s3_nivo`` and ``s3_ever`` have the following columns:
#' \describe{
#'   \item{\code{Unique_Subject_Identifier}}{Identifier}
#'   \item{\code{Treatment}}{"NIVOLUMAB" or "EVEROLIMUS"}
#'   \item{\code{Region}}{Sample region}
#'   \item{\code{Sex}}{"M" or "F"}
#'   \item{\code{Derived_Age_at_Consent}}{Age at consent}
#'   \item{\code{Race}}{"WHITE" or "OTHER"}
#'   \item{\code{CRF_MSKCC_Risk_Group}}{"FAVORABLE", "INTERMEDIATE" or "POOR"}
#'   \item{\code{Prior antiangiogenic regimens (≥2)}}{}
#'   \item{\code{OS}}{Overall survival time}
#'   \item{\code{OS_Censor}}{Overall survival status}
#' }
#' @source
#' Liu, D., Schilling, B., Liu, D. et al. Integrative molecular and clinical modeling of
#' clinical outcomes to PD1 blockade in patients with metastatic melanoma.
#' Nat Med 25, 1916–1927 (2019). https://doi.org/10.1038/s41591-019-0654-5
"li2019_pheno"


#' @title Li 2019 supplement IDs to clearnames
#' @description The supplemental data s1, s2, s3_nivo and s3_ever have clear names
#' in the paper. This named vector maps the supplement IDs to the clear names.
#' @format A named character vector with 4 elements. Names are the supplement IDs,
#' values are the clear names.
"li2019_studies_clearnames"

#' @title Li 2019 measurements
#' @description
#' Samples in the studies were measured at baseline and at weeks 4, 6 and 8. Not all
#' samples were measured at all timepoints. The measurements are stored in a list
#' with 4 elements, one for each study. Each element is a list a tibble for each timepoint.
#'
#' Each tibble starts with a column \code{Unique_Subject_Identifier} that identifies
#' the sample. The remaining columns are the measurements.
#'
#' @format
#' A list of 4 of "s1", "s2", "s3_nivo" and "s3_ever". Inside, a list of tibbles with
#' measurements for each timepoint. The names of the inside-list corresponds to the
#' timepoint ("baseline", "week 4", "week 6" or "week 8").
#'
#' @source
#' Liu, D., Schilling, B., Liu, D. et al. Integrative molecular and clinical modeling of
#' clinical outcomes to PD1 blockade in patients with metastatic melanoma.
#' Nat Med 25, 1916–1927 (2019). https://doi.org/10.1038/s41591-019-0654-5
"li2019_measurements"