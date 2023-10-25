# dataMelanoma::create_data_project("2019-harel-Cell")
proj_dir <- "data-raw/2019-harel-Cell/"


#### 1. Download data
supfile <- file.path(proj_dir, "data", "1-s2.0-S0092867419309006-mmc1.xlsx")
download.file(
    url = "https://ars.els-cdn.com/content/image/1-s2.0-S0092867419309006-mmc1.xlsx",
    destfile = supfile,
    method = "wget"
)

#### 2. Read data
### 2.1 Phenodata
harel_pheno <- readxl::read_excel(supfile, sheet = "S1A", skip = 1, na = "NaN")
# Metadata contains spaces in the sample names
# the actual data always "_" instead of spaces
harel_pheno[["Sample ID"]] <- gsub(" ", "_", harel_pheno[["Sample ID"]])


# Patients were categorized into responders (complete or partial regression) and
# non-responders (progressive disease) according to RECIST v1.0 guidelines
# "Response" contains "PD", "PR", "CR" or "SD" (stable disease)
harel_pheno <- harel_pheno |>
    # Filter out stable disease
    dplyr::filter(Response %in% c("PD", "PR", "CR")) |>
    # Add a column with the response as defined in the paper
    dplyr::mutate(response_paper = ifelse(Response == "PD", "non-responder", "responder"))
outcome_noSD <- harel_pheno[["response_paper"]]
names(outcome_noSD) <- harel_pheno[["Sample ID"]]

### 2.1 Read S1C(TIL) and S1D(aPD1) protein measurements, filtered for 70% valid values and gene names median-merged
data_70 <- list(
    aPD1 = readxl::read_excel(
        supfile,
        sheet = "S1D", skip = 1, na = "NaN"
    ),
    til = readxl::read_excel(
        supfile,
        sheet = "S1C", skip = 1, na = "NaN"
    )
)
data_mats <- lapply(data_70, function(x) {
    datapart_x_samples <- as.matrix(x[, grepl("^(PD1_)|(TIL_)", colnames(x))])
    genename_column <- grepl("Gene name", colnames(x))
    rownames(datapart_x_samples) <- x[genename_column][[1]]
    return(datapart_x_samples)
})

lapply(data_mats, colnames)
lapply(data_mats, dim)
# $aPD1
# [1] 4620   67
# $til
# [1] 4588   42

#### 3. Save data in qrds format
status_responder_noSD <- outcome_noSD
qs::qsave(status_responder_noSD, file.path(proj_dir, "res", "status_responder_noSD.qs"))
qs::qsave(harel_pheno, file.path(proj_dir, "res", "harel_pheno.qs"))
qs::qsave(data_mats, file.path(proj_dir, "res", "data_mats.qs"))


#### 4. usethis::use_data()
harel2019_pheno <- harel_pheno
usethis::use_data(harel2019_pheno, overwrite = TRUE)
# nolint start
# # pacman::p_install("sinew", force = FALSE)
# # usethis::use_package("sinew", type = "Suggests")
# sinew::makeOxygen(harel2019_pheno) # seems to not work for a lot of data types
# nolint end

harel2019_responder_noSD <- status_responder_noSD
usethis::use_data(harel2019_responder_noSD, overwrite = TRUE)

harel2019_protmats <- data_mats
usethis::use_data(harel2019_protmats, overwrite = TRUE)
