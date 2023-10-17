# dataMelanoma::create_data_project("2022-Lozano-NatMed")
proj_dir <- "data-raw/2022-Lozano-NatMed/"


#### 1. Download data
download.file(
    url = "https://static-content.springer.com/esm/art%3A10.1038%2Fs41591-021-01623-z/MediaObjects/41591_2021_1623_MOESM3_ESM.xlsx",
    destfile = file.path(proj_dir, "data", "41591_2021_1623_MOESM3_ESM.xlsx")
)
download.file(
    url = "https://anlab.stanford.edu/Lozano_etal_Supporting_Data.zip",
    destfile = file.path(proj_dir, "data", "Lozano_etal_Supporting_Data.zip")
)
download.file(
    url = "https://anlab.stanford.edu/Lozano_etal_Supporting_Code.zip",
    destfile = file.path(proj_dir, "data", "Lozano_etal_Supporting_Code.zip")
)

#### 2. Read data
# pheno <- readxl::read_excel(
#     file.path(proj_dir, "data", "41591_2021_1623_MOESM3_ESM.xlsx"),
#     sheet = "Table S1", na = "NA", skip = 3
# )
pheno_discovery <- readxl::read_excel(
    file.path(proj_dir, "data", "41591_2021_1623_MOESM3_ESM.xlsx"),
    sheet = "Table S3", na = "NA", skip = 3
)

unzip(
    zipfile = file.path(proj_dir, "data", "Lozano_etal_Supporting_Data.zip"),
    exdir = file.path(proj_dir, "data", "Lozano_etal_Supporting_Data_UNZIPPED")
)
cytof <- readxl::read_excel(
    file.path(proj_dir, "data", "Lozano_etal_Supporting_Data_UNZIPPED", "CyTOF_overview.xlsx"),
    skip = 3
)
colnames(cytof)[-1] <- paste0("cytof_", colnames(cytof)[-1])
data_joint <- dplyr::right_join(pheno_discovery, cytof, by = c("Patient ID" = "PID")) |>
    dplyr::filter(!is.na(`Severe irAE status (1=Yes, 0=No)d`))
table(data_joint[["Severe irAE status (1=Yes, 0=No)d"]])


#### 3. Save data in qrds format
qs::qsave(pheno_discovery, file.path(proj_dir, "res", "pheno_discovery.qs"))
qs::qsave(cytof, file.path(proj_dir, "res", "cytof.qs"))
qs::qsave(data_joint, file.path(proj_dir, "res", "data_joint.qs"))


#### 4. usethis::use_data()
lozano2022_pheno_cytof <- data_joint
usethis::use_data(lozano2022_pheno_cytof, overwrite = TRUE)
