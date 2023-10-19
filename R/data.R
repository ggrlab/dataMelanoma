# See https://r-pkgs.org/data.html#sec-documenting-data

#' @title Phenotypic data from Lozano et al.
#' @description Phenotypic data from Lozano et al.
#' @format
#'  A data frame with 18 rows (samples) and 39 columns (features).
#' The first 18 columns are phenotypic features, the remaining 20 columns are CyTOF features.
#' The CyTOF features are prefixed with `cytof_` the values are proportions of cells in the sample.
#' All populations are normalized relative to total evaluable PBMCs,
#'
#' @source Lozano, A.X., Chaudhuri, A.A., Nene, A. et al. T cell characteristics associated with toxicity to immune checkpoint blockade in patients with melanoma. Nat Med 28, 353–362 (2022). https://doi.org/10.1038/s41591-021-01623-z
"lozano2022_pheno_cytof"

#' @title Simulated data from intraassay data
#' @description Simulated data from intraassay data, with 100 samples. Created within /home/gugl/clonedgit/paper/2023-Glehr_rROC_code
#'
#' @format
#' A data frame with 100 rows (samples) and 143 columns (features).
#' Of the 143 columns, 141 are cell population counts as features, and "V1" (column 1) is a sample name and "fake_labels" are randomly sampled group labels.
#' @source https://git.uni-regensburg.de/paper/2023-Glehr_rROC_code.git
"sim_intraassay_sim00_pure_estimate"
