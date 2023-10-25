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

#' @title Zhang2022 bulk data
#' @description Data from Zhang et al. 2022 which combines data from 10 immunotherapy cohorts.
#' Especially they used the following cohorts for their training and validation sets:
#'
#'      - Braun 2020  Braun DA, Hou Y, Bakouny Z, Ficial M, Sant’ Angelo M, Forman J, et al. Interplay of somatic alterations and immune infiltration modulates response to PD-1 blockade in advanced clear cell renal cell carcinoma. Nat Med. 2020;26:909–18. https://doi.org/10.1038/s41591-020-0839-y
#'      - Mariathasan 2018 Mariathasan S, Turley SJ, Nickles D, Castiglioni A, Yuen K, Wang Y, et al. TGFβ attenuates tumour response to PD-L1 blockade by contributing to exclusion of T cells. Nature. 2018;554:544–8. https://doi.org/10.1038/nature25501
#'      - Liu 2019  Liu D, Schilling B, Liu D, Sucker A, Livingstone E, Jerby-amon L, et al. Integrative molecular and clinical modeling of clinical outcomes to PD1 blockade in patients with metastatic melanoma. Nat Med. 2019;25. https://doi.org/10.1038/s41591-019-0654-5
#'      - Gide 2019 Gide TN, Quek C, Menzies AM, Tasker AT, Shang P, Holst J, et al. Distinct Immune Cell Populations Define Response to Anti-PD-1 Monotherapy and Anti-PD-1/Anti-CTLA-4 Combined Therapy. Cancer Cell. 2019;35:238-255.e6. https://doi.org/10.1016/j.ccell.2019.01.003
#'      - Riaz 2017 Riaz N, Havel JJ, Makarov V, Desrichard A, Urba WJ, Sims JS, et al. Tumor and Microenvironment Evolution during Immunotherapy with Nivolumab. Cell. 2017;171:934-949.e16. https://doi.org/10.1016/j.cell.2017.09.028
#'
#' The separate, independent testing cohort comes from the following publications:
#'
#'      - Zhao 2019 Zhao J, Chen AX, Gartrell RD, Silverman AM, Aparicio L, Chu T, et al. Immune and genomic correlates of response to anti-PD-1 immunotherapy in glioblastoma. Nat Med. 2019;25:462–9. https://doi.org/10.1038/s41591-019-0349-y
#'      - Snyder 2017 Snyder A, Nathanson T, Funt SA, Ahuja A, Buros Novik J, Hellmann MD, et al. Contribution of systemic and somatic factors to clinical response and resistance to PD-L1 blockade in urothelial cancer: An exploratory multi-omic analysis. Minna JD, editor. PLOS Med. 2017;14:e1002309. https://doi.org/10.1371/journal.pmed.1002309
#'      - Hugo 2016  Hugo W, Zaretsky JM, Sun L, Song C, Moreno BH, Hu-Lieskovan S, et al. Genomic and Transcriptomic Features of Response to Anti-PD-1 Therapy in Metastatic Melanoma. Cell. 2016;165:35–44. https://doi.org/10.1016/j.cell.2016.02.065
#'      - Van 2015 Van Allen EM, Miao D, Schilling B, Shukla SA, Blank C, Zimmer L, et al. Erratum for the Report “Genomic correlates of response to CTLA-4 blockade in metastatic melanoma” by E. M. Van Allen, D. Miao, B. Schilling, S. A. Shukla, C. Blank, L. Zimmer, A. Sucker, U. Hillen, M. H. Geukes Foppen, S. M. Goldinger, J. Utikal, J. C. Ha. Science. 2016;352:aaf8264–aaf8264. https://doi.org/10.1126/science.aaf8264
#'      - Kim 2018 Kim ST, Cristescu R, Bass AJ, Kim K-M, Odegaard JI, Kim K, et al. Comprehensive molecular characterization of clinical responses to PD-1 inhibition in metastatic gastric cancer. Nat Med. 2018;24:1449–58. https://doi.org/10.1038/s41591-018-0101-z
#'
#' Find an extensive description of the data in the original publications and in
#' Zhang2022, supplementary table S3. https://static-content.springer.com/esm/art%3A10.1186%2Fs13073-022-01050-w/MediaObjects/13073_2022_1050_MOESM1_ESM.pdf
#'
#' Following the analysis supplied in figshare https://figshare.com/articles/online_resource/Integrated_analysis_of_single-cell_and_bulk_RNA_sequencing_data_reveals_a_pan-cancer_stemness_signature_predicting_immunotherapy_response/17654633
#'
#'  1.  The training data was established by using "ios.Rdata", which is the data from the 10 cohorts combined.
#'      The authors did not give more information how the data was gathered exactly.
#'  2. The data was preprocessed with sva::ComBat()  (default parameters) to remove batch effects.
#'  3. Data from the first 5 described cohorts was split randomly into
#'      training (80%, ``zhang2022_training``) and
#'      validation (20%, ``zhang2022_validation``) sets.
#'  4. The remaining 5 cohorts were used as independent testing set (``zhang2022_testing``).
#'
#' Apart from the gene expression data, they established a ``Stem.Sig`` gene signature
#' which consists of selected genes (no coefficients) that were
#' "correlated with CytoTRACE scores" in 34 scRNA-seq datasets.
#'
#' @source Zhang, Z., Wang, ZX., Chen, YX. et al. Integrated analysis of single-cell and bulk RNA sequencing data reveals a pan-cancer stemness signature predicting immunotherapy response. Genome Med 14, 45 (2022). https://doi.org/10.1186/s13073-022-01050-w
#'
zhang2022 <- function() {
    # placeholder
    # documentation function
}

#' @title Zhang 2022 training bulk RNAseq data
#' @description Training data from Zhang2022, post ComBat() preprocessing. See also \code{\link{zhang2022}}.
#' @format
#' A tibble with 618 rows and 15904 columns. Of those columns, the first 8 are phenodata
#' per sample (rows): batch, ID, OS, status, PFS, status2, response and BOR. The remaining
#' columns are gene expression data.
"zhang2022_training"

#' @title Zhang 2022 validation bulk RNAseq data
#' @description Validation data from Zhang2022, post ComBat() preprocessing. See also \code{\link{zhang2022}}.
#' @format
#' A tibble with 154 rows and 15904 columns. Of those columns, the first 8 are phenodata
#' per sample (rows): batch, ID, OS, status, PFS, status2, response and BOR. The remaining
#' columns are gene expression data.
"zhang2022_validation"

#' @title Zhang 2022 test bulk RNAseq data
#' @description Test data from Zhang2022, post ComBat() preprocessing. See also \code{\link{zhang2022}}.
#' @format
#' A tibble with 149 rows and 15904 columns. Of those columns, the first 8 are phenodata
#' per sample (rows): batch, ID, OS, status, PFS, status2, response and BOR. The remaining
#' columns are gene expression data.
"zhang2022_test"

#' @title Zhang 2022 Stem.Sig gene signature
#' @description Stem.Sig gene signature from Zhang2022, see also \code{\link{zhang2022}}.
#' @format
#' A character vector of 454 gene names, identified via a single cell analysis of 34
#' scRNA-seq datasets.
"zhang2022_Stem.Sig"

#' @title Spencer 2021 microbiome data, phenodata
#' @description Data for the samples from Spencer 2021
#' @source Christine N. Spencer et al. ,Dietary fiber and probiotics influence the gut microbiome and melanoma immunotherapy response.Science374,1632-1640(2021).DOI:10.1126/science.aaz7015
#' @format
#' A tibble with 167 rows (samples) and 42 columns (features).
"spencer2021_pheno"

#' @title Spencer 2021 microbiome data, LKT PPM
#' @description
#' Relative abundances of Last Known Taxon features (lowest taxon known for a feature,
#' up to species), in Parts Per Million (PPM). Data for the samples from Spencer 2021
#' @source Christine N. Spencer et al. ,Dietary fiber and probiotics influence the gut microbiome and melanoma immunotherapy response.Science374,1632-1640(2021).DOI:10.1126/science.aaz7015
#' @format
#' A tibble with 225 rows (features) and 1 + 167 columns (1 feature, 167 samples).
"spencer2021_lkt_ppm"

#' @title Lee2022 (curated) phenodata
#' @description Manually selected columns from lee2022_treesummarizedexperiment, see
#' also \code{\link{lee2022_treesummarizedexperiment}}.
#' @source Lee, K.A., Thomas, A.M., Bolte, L.A. et al. Cross-cohort gut microbiome
#' associations with immune checkpoint inhibitor response in advanced melanoma. Nat Med
#' ü28, 535–544 (2022). https://doi.org/10.1038/s41591-022-01695-5
#' @format A tibble with 315 rows (samples) and 14 columns (features):
#'
#'   study_name, subject_id, body_site, age, age_category, gender, PMID, number_reads,
#'   number_bases, minimum_read_length, median_read_length, NCBI_accession,
#' lee_subcohort, PFS12
"lee2022_pheno_curated"

#' @title Lee2022 preprocessed microbiome data
#' @description Preprocessed microbiome data from Lee2022, see also
#' \code{\link{lee2022_treesummarizedexperiment}}. All melanoma data from
#' curatedMetagenomicData was acquired. Those came from the following other ``study_name``
#' refering to other papers.
#'
#'  - FrankelAE_2017
#'  - GopalakrishnanV_2018
#'  - LeeKA_2022
#'  - MatsonV_2018
#'  - PetersBA_2019
#'  - WindTT_2020
#'
#' Data preprocessing was according to "Machine learning analysis." in the paper's methods:
#'
#'  - Excluding samples with low sequencing depth (number_reads must be > 1e6)
#'  1. Remove species with relative abundances with low overall abundance ("1e-4 maximum abundance cutoff")
#'  2. log10 transformed after pseudocount of 1e-5
#'  3. Standardized as z-scores
#'
#' @format
#' Preprocessed data from 315 samples (columns) and 672 species (rows). The rownames
#' are coded according to different taxonomies. Use the package "mia" to decode them,
#' but potentially focus on the \code{\link{lee2022_treesummarizedexperiment}}!
#'
#' k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales|f__Leuconostocaceae|g__Leuconostoc|s__Leuconostoc_garlicum
#'
#'
"lee2022_relative_abundance_preprocessed"

#' @title Lee2022 treesummarizedexperiment microbiome data
#' @description Microbiome data from Lee2022, see also
#' \code{\link{lee2022_treesummarizedexperiment}}. All melanoma data from
#' curatedMetagenomicData was acquired. Those came from the following other ``study_name``
#' refering to other papers.
#'
#'  - FrankelAE_2017
#'  - GopalakrishnanV_2018
#'  - LeeKA_2022
#'  - MatsonV_2018
#'  - PetersBA_2019
#'  - WindTT_2020
#'
#' No further dataprocessing was done.
#'
#' @format
#' Preprocessed data from 315 samples (columns) and 672 species (rows). The rownames
#' are coded according to different taxonomies. Use the package "mia" to decode them.
#'
#' k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales|f__Leuconostocaceae|g__Leuconostoc|s__Leuconostoc_garlicum
#'
#'
"lee2022_treesummarizedexperiment"
