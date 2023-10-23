# dataMelanoma::create_data_project("2018-gopa-Science")
proj_dir <- "data-raw/2018-gopa-Science/"


#### 1. Download data
# sudo apt install libgsl-dev   # DirichletMultinomial needs this
pacman::p_install("DirichletMultinomial", force = FALSE)
pacman::p_install("curatedMetagenomicData", force = FALSE)

pacman::p_load(dplyr)
melanoma_gopa <-tibble::as_tibble(curatedMetagenomicData::sampleMetadata) |>
    dplyr::filter(grepl("GopalakrishnanV_2018", study_name, ignore.case = TRUE)) 

data_gopa <- melanoma_gopa |> curatedMetagenomicData::returnSamples(dataType = "relative_abundance")
#### 2. Read data
# pheno <- readxl::read_excel(
#     file.path(proj_dir, "data", "41591_2021_1623_MOESM3_ESM.xlsx"),
#     sheet = "Table S1", na = "NA", skip = 3
# )
gopa_relative_abundance <- SummarizedExperiment::assay(data_gopa)
gopa_pheno <- SummarizedExperiment::colData(data_gopa)
gopa_pheno <- gopa_pheno[, !apply(gopa_pheno, 2, function(x) all(is.na(x)))]
melanoma_gopa[, !apply(melanoma_gopa, 2, function(x) all(is.na(x)))]

# None of the data have any status (responder/nonresponder) whatsoever, I am not continuing with this data
# 
# #### 3. Save data in qrds format
# qs::qsave(pheno, file.path(proj_dir, "res", "pheno.qs"))


# #### 4. usethis::use_data()
# lozano2022_pheno <- pheno
# usethis::use_data(lozano2022_pheno, overwrite = TRUE)
