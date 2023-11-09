# dataMelanoma::create_data_project("2022-lee-NatMed")
proj_dir <- "data-raw/2022-lee-NatMed/"


#### 1. Download data
# sudo apt install libgsl-dev   # DirichletMultinomial needs this
pacman::p_install("DirichletMultinomial", force = FALSE)
pacman::p_install("curatedMetagenomicData", force = FALSE)
pacman::p_load(dplyr)
# https://stackoverflow.com/questions/77370659/error-failed-to-collect-lazy-table-caused-by-error-in-db-collect-using
devtools::install_version("dbplyr", version = "2.3.4")

curatedMetagenomicData::sampleMetadata |>
    dplyr::filter(grepl("melanoma", disease, ignore.case = TRUE)) |>
    pull(study_name) |>
    unique()
# "FrankelAE_2017"       "GopalakrishnanV_2018" "LeeKA_2022"
# "MatsonV_2018"         "PetersBA_2019"        "WindTT_2020"

# Follow Paper: Methods, "The pulicly available datasets considered."
melanoma_studies_lee <-
    tibble::as_tibble(curatedMetagenomicData::sampleMetadata) |>
    dplyr::filter(grepl("melanoma", disease, ignore.case = TRUE)) |>
    # We excluded any samples taken
    # [EXCLUDED:] after the start of ICI therapy
    # Not in metadata
    # [EXCLUDED:] nonmetagenomic samples
    # ??
    # [EXCLUDED:] nonfecal samples
    dplyr::filter(body_site == "stool") |>
    # [EXCLUDED:] samples with low sequencing depth(<1 million reads)
    dplyr::filter(number_reads > 1e6)

data_lee <- melanoma_studies_lee |> curatedMetagenomicData::returnSamples(dataType = "relative_abundance", rownames="long")



#### 2. Read data
SummarizedExperiment::colData(data_lee) |>
    tibble::as_tibble() |>
    select(study_name, location) |>
    table(useNA = "always")
SummarizedExperiment::colData(data_lee) |>
    tibble::as_tibble() |>
    select(study_name, subcohort) |>
    table(useNA = "always")

sample_subcohort_info <- SummarizedExperiment::colData(data_lee) |>
    tibble::as_tibble() |>
    select(study_name, subcohort, location)
sample_subcohort_info[["lee_subcohort"]] <- NA_character_
for (sample_i in 1:nrow(sample_subcohort_info)) {
    current <- sample_subcohort_info[sample_i, ]
    if ((is.na(current["subcohort"]) && is.na(current["location"])) || current["study_name"] == "PetersBA_2019") {
        sample_subcohort_info[sample_i, ][["lee_subcohort"]] <- current[["study_name"]]
    } else if (current["study_name"] == "LeeKA_2022") {
        if (!is.na(current["location"])) {
            sample_subcohort_info[sample_i, ][["lee_subcohort"]] <- current[["location"]]
        } else {
            sample_subcohort_info[sample_i, ][["lee_subcohort"]] <- current[["subcohort"]]
        }
    } else {
        print(current)
        stop("I do not know the current sample's subcohort.")
    }
}
data_lee[["lee_subcohort"]] <- sample_subcohort_info[["lee_subcohort"]]

print(table(
    SummarizedExperiment::colData(data_lee)[["lee_subcohort"]],
    factor(SummarizedExperiment::colData(data_lee)[["ORR"]], levels = c("yes", "no")),
    useNA = "always"
))
cat(
    "Comparing this table with Paper, Extended Data Fig.1 B [ORR]",
    "There are considerable differences in numbers and available data.",
    "Fine are: Barcelona, Leeds, WindTT_2020, PRIMM-NL.",
    "Missing responder status are: GopalakrishnanV_2018, MatsonV_2018, PetersBA_2019.",
    "Different Responder/Non-responder numbers: FrankelAE_2017, Manchester, PRIMM-UK.",
    sep = "\n"
)

# This dataset:
#                        yes no <NA>
#   FrankelAE_2017        24 15    0
#   Manchester            12 13    0
#   PRIMM-UK              33 22    0
# Paper Extended Data Fig. 1:
#                        yes no <NA>
#   FrankelAE_2017        22 15    0
#   Manchester            13 12    0
#   PRIMM-UK              32 23    0

# PFS is the same as in the paper
print(table(
    SummarizedExperiment::colData(data_lee)[["lee_subcohort"]],
    factor(SummarizedExperiment::colData(data_lee)[["PFS12"]], levels = c("yes", "no")),
    useNA = "always"
))
print(apply(table(
    SummarizedExperiment::colData(data_lee)[["lee_subcohort"]],
    factor(SummarizedExperiment::colData(data_lee)[["PFS12"]], levels = c("yes", "no")),
    useNA = "always"
), 2, sum))

## The data names are slightly different. We need to change them to match the names in the metadata
data_lee$subject_id <- sub("SAM_P", "SAM_", data_lee$subject_id)
data_lee$subject_id[!data_lee$subject_id %in% rownames(data_lee)]


data_lee_pheno_curated <- data_lee |>
    SummarizedExperiment::colData() |>
    tibble::as_tibble() |>
    dplyr::select(study_name, subject_id, body_site, age, age_category, gender, PMID, number_reads, number_bases, minimum_read_length, median_read_length, NCBI_accession, lee_subcohort, PFS12)

# tmp <- data.frame(data_lee_pheno_curated[, c("study_name", "subject_id", "RECIST", "ORR")])
# table(tmp[, c("RECIST", "ORR")])


data_lee_preprocessed <- SummarizedExperiment::assay(data_lee)
# Preprocessing according to "Machine learning analysis." in Paper Methods
# 1. Remove species with relative abundances with low overall abundance ("1e-4 maximum abundance cutoff")
low_abundance_bool <- apply(data_lee_preprocessed, 1, function(x) max(x) < 1e-4)
data_lee_preprocessed <- data_lee_preprocessed[!low_abundance_bool, ]

# 2. log10 transformed after pseudocount of 1e-5
data_lee_preprocessed <- log10(data_lee_preprocessed + 1e-5)

# 3. Standardized as z-scores
data_means <- apply(data_lee_preprocessed, 1, mean)
data_sd <- apply(data_lee_preprocessed, 1, sd)
data_lee_preprocessed <- sweep(data_lee_preprocessed, 1, data_means, "-")
data_lee_preprocessed <- sweep(data_lee_preprocessed, 1, data_sd, "/")

# Maybe see "Definition of response to therapy" in Paper Methods

#### 3. Save data in qrds format
qs::qsave(data_lee, file.path(proj_dir, "res", "data_lee.qs"))
qs::qsave(data_lee_pheno_curated, file.path(proj_dir, "res", "data_lee_pheno_curated.qs"))

#### 4. usethis::use_data()
lee2022_treesummarizedexperiment <- data_lee
usethis::use_data(lee2022_treesummarizedexperiment, overwrite = TRUE)

lee2022_pheno_curated <- data_lee_pheno_curated
usethis::use_data(lee2022_pheno_curated, overwrite = TRUE)

lee2022_relative_abundance_preprocessed <- data_lee_preprocessed
usethis::use_data(lee2022_relative_abundance_preprocessed, overwrite = TRUE)
