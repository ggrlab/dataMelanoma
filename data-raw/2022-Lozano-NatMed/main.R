# dataMelanoma::create_data_project("2022-Lozano-NatMed")
proj_dir <- "data-raw/2022-Lozano-NatMed/"


#### 1. Download data
download.file(
    url = "INSERT_URL_HERE",
    destfile = file.path(proj_dir, "data")
)
