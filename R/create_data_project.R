#' @title Create a data project stump
#' @description Creates all directories and first files for a data project
#' @param name the name of the project
#' @export
create_data_project <- function(name) {
    proj_dir <- file.path("data-raw", name)
    dir.create(proj_dir, recursive = TRUE)
    for (folder_x in c("src", file.path("src", "_functions"), "data", "res")) {
        dir.create(file.path(proj_dir, folder_x), recursive = TRUE)
    }
    file.create(file.path(proj_dir, "main.R"))
    file.create(file.path(proj_dir, "src", "f01_example.R"))

    # Write to main.R

    cat(
        paste0("# dataMelanoma::create_data_project(\"", name, "\")"),
        paste0("proj_dir <- \"", proj_dir, "/\""),
        "",
        "",
        "#### 1. Download data",
        "download.file(",
        "    url = \"INSERT_URL_HERE\",",
        "    destfile = file.path(proj_dir, \"data\")",
        ")", "", "",
        "#### 2. Read data",
        "# pheno <- readxl::read_excel(",
        '#     file.path(proj_dir, "data", "41591_2021_1623_MOESM3_ESM.xlsx"),',
        '#     sheet = "Table S1", na = "NA", skip = 3',
        "# )",
        "", "",
        "#### 3. Save data in qrds format",
        'qs::qsave(pheno, file.path(proj_dir, "res", "pheno.qs"))',
        "", "",
        "#### 4. usethis::use_data()",
        "lozano2022_pheno <- pheno",
        "usethis::use_data(lozano2022_pheno, overwrite = TRUE)",
        file = file.path(proj_dir, "main.R"),
        append = FALSE,
        sep = "\n"
    )

    # Write to f01_example.R
    cat(
        "# Here comes the code, start with downloading the data",
        file = file.path(proj_dir, "src", "f01_example.R"),
        append = FALSE,
        sep = "\n"
    )
}
