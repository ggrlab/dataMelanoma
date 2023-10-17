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
    appending <- FALSE
    for (line_x in list(
        paste0("# dataMelanoma::create_data_project(\"", name, "\")"),
        paste0("proj_dir <- \"", proj_dir, "/\""),
        "",
        "",
        "#### 1. Download data",
        "download.file(",
        "    url = \"INSERT_URL_HERE\",",
        "    destfile = file.path(proj_dir, \"data\")",
        ")"
    )) {
        cat(
            line_x, "\n",
            file = file.path(proj_dir, "main.R"),
            append = appending,
            sep = ""
        )
        appending <- TRUE
    }

    # Write to f01_example.R
    fileconn <- file(file.path(proj_dir, "src", "f01_example.R"))
    writeLines(
        text = paste0(
            "# Here comes the code, start with downloading the data"
        ),
        con = fileconn
    )
    close(fileconn)
}
