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
}
