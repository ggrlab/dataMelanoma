# dataMelanoma::create_data_project("2021-spencer-Science")
proj_dir <- "data-raw/2021-spencer-Science/"


#### 1. Download data
download.file(
    url = "https://raw.githubusercontent.com/mda-primetr/Spencer_et_al_2021/main/data/PD1_Wargo_Human_WGS_Relabund_and_metadata_light_filtering.xlsx",
    destfile = file.path(proj_dir, "data", "PD1_Wargo_Human_WGS_Relabund_and_metadata_light_filtering.xlsx")
)


#### 2. Read data
# For a nice explanation of the dataset, see
# https://github.com/mda-primetr/Spencer_et_al_2021/blob/main/docs/WGSHuman.md
pheno <- readxl::read_excel(
    file.path(proj_dir, "data", "PD1_Wargo_Human_WGS_Relabund_and_metadata_light_filtering.xlsx"),
    sheet = "Metadata", na = "N_A"
)

# Relative abundances of Last Known Taxon features (lowest taxon known for a feature, up to species), in Parts Per Million (PPM)
lkt_ppm <- readxl::read_excel(
    file.path(proj_dir, "data", "PD1_Wargo_Human_WGS_Relabund_and_metadata_light_filtering.xlsx"),
    sheet = "LKT_PPM", na = "N_A"
)

#### 3. Save data in qrds format
qs::qsave(pheno, file.path(proj_dir, "res", "pheno.qs"))
qs::qsave(lkt_ppm, file.path(proj_dir, "res", "lkt_ppm.qs"))

#### 4. usethis::use_data()
spencer2021_pheno <- pheno
usethis::use_data(spencer2021_pheno, overwrite = TRUE)

spencer2021_lkt_ppm <- lkt_ppm
usethis::use_data(spencer2021_lkt_ppm, overwrite = TRUE)
