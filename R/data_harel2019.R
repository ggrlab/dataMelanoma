#' @title Phenodata for Harel2019
#' @description Phenodata taken from Supplementary table S1A. Samples have response to
#' treatment (PD, PR, CR or SD). Stable disease (SD) was excluded from the analysis
#' following the paper.
#' @format A data frame with 109 rows and 14 variables. Highlighted columns:
#' \itemize{
#'   \item{\code{Response}}{Response to treatment: PD, PR, CR or SD. Samples with SD were excluded.}
#'   \item{\code{Sample taken after treatment}}{There are 2 samples which were taken AFTER treatment!}
#'   \item{\code{response_paper}}{Response to treatment according to the paper.}
#'   \item{...}{Self explanatory}
#' }
#' @source
#' Harel et al. "Proteomics of melanoma response to immunotherapy reveals mitochondrial
#' dependence." Cell 179.1 (2019): 236-250. https://doi.org/10.1016/j.cell.2019.08.012
#' @details
#' In Harel et al, 2019, Cell, the authors describe melanoma response
#' to immunotherapy. They use high-resolution mass spectrometry to quantify 4,300
#' proteins across 116 patients. Formalin-fixed paraffin-embedded (FFPE) tissues from
#' 42 metastatic melanoma patients treated with TIL-based adoptive cell transfer and 74
#' treated with anti-PD1 immunotherapy were included.
#'
#' Samples were taken before treatment except for two patients taken 11 or 18 days after
#' treatment initialization. Patients are split into 21/40 responders,
#' 21/27 non-responders and 0/7 stable disease according to RECIST v1.0
#' guidelines (TIL/anti-PD1 cohorts). See ``Tumor sample collection`` in the paper's
#' method section.
"harel2019_pheno"


#' @title Named non-/responder status for Harel2019
#' @description
#'  Phenodata taken from Supplementary table S1A.
#'  See also \code{\link{harel2019_pheno}}.
#' @format A named character vector of length 109. Names are the sample IDs (\code{harel2019_pheno[["Sample ID"]]}),
#' values are the response to treatment ("non-responder" or "responder").
#' @source
#' Harel et al. "Proteomics of melanoma response to immunotherapy reveals mitochondrial
#' dependence." Cell 179.1 (2019): 236-250. https://doi.org/10.1016/j.cell.2019.08.012
"harel2019_responder_noSD"

#' @title Protein matrices for Harel2019
#' @description
#'  Data taken from Supplementary tables S1C and S1D.
#'  See also \code{\link{harel2019_pheno}}.
#' @format A list with two elements:
#' \describe{
#'      \item{\code{aPD1}}{
#'          Protein matrix with 4620 genes (rows) of 67 samples (columns) from
#'          Supplementary table S1D. Rownames are gene names, columns are sample IDs.
#'      }
#'      \item{\code{til}}{
#'          Protein matrix with 4588 genes (rows) of 42 samples (columns) from
#'          Supplementary table S1C. Rownames are gene names, columns are sample IDs.
#'      }
#' }
#'
#' @details
#' We used the data available under [Table S1](https://ars.els-cdn.com/content/image/1-s2.0-S0092867419309006-mmc1.xlsx)
#' of the publication in ``1-s2.0-S0092867419309006-mmc1.xlsx``,
#' sheets ``S1C`` and ``S1D``.
#'
#' !!Note!! that it seems that the data in Table S2B is inconsistent to S1B, S1D and S4A.
#'
#' According to the section ``Proteomics statistical analysis`` in the paper's method
#' section, the following analysis was performed .
#'
#'      For the clinical tumor data, normalized ratio tumor/SILAC data were
#'      log2-transformed and the protein groups were filtered to have at least 70%
#'      valid values, reaching a list of 4588,4620 or 4416 protein groups for the
#'      TIL, the anti-PD1 or the combined datasets respectively, which were further used
#'      for all downstream analyses. Dataset integration was based on gene name;
#'      multiple entries for the same gene name were integrated to a single entry by
#'      calculating the median expression value. Data were normalized by subtracting
#'      most frequent value in each sample. To extract DEPs between responders and
#'      non-responders multiple comparisons were performed; a two-sample Student's ttest
#'      was performed with a p value threshold of 0.05 for each of the two datasets,
#'      following by 2D annotation enrichment test (Cox and Mann, 2012) with FDR q-value
#'      0.02 to derive the differential functional groups in each of the two datasets.
#'      A two-sample Student's t test with a permutation-based FDR q-value of 0.1 and
#'      S0 (Tusher et al., 2001) of 0.1 was performed for the anti-PD1 dataset or the
#'      combined dataset of both treatments, to extract significantly changing proteins.
#'
#' From main text; ``Functional Analysis of Responders and Non-responders to Immunotherapy``:
#'
#'      Initial bioinformatic analysis examined the functional differences between
#'      responders and non-responders in each therapy. We first applied a low stringency
#'      Student's t test with a nominal p value cutoff (p value < 0.05) and found 414
#'      and 636 differentially expressed proteins (DEPs) in the TIL and the anti-PD1
#'      cohorts [...].
#'
#' @source
#' Harel et al. "Proteomics of melanoma response to immunotherapy reveals mitochondrial
#' dependence." Cell 179.1 (2019): 236-250. https://doi.org/10.1016/j.cell.2019.08.012
"harel2019_protmats"
