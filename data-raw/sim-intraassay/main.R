# dataMelanoma::create_data_project("sim-intraassay")
proj_dir <- "data-raw/sim-intraassay/"


#### 1. Download data
dir.create(file.path(proj_dir, "data"), showWarnings = FALSE)
download.file(
    url = "https://figshare.com/ndownloader/files/42862243",
    destfile = file.path(proj_dir, "data", "sim00_pure_estimate_node_counts_df.csv")
)


#### 2. Read data
sim00_pure_estimate <- data.table::fread(file.path(proj_dir, "data", "sim00_pure_estimate_node_counts_df.csv"))
sim00_pure_estimate <- tibble::as_tibble(sim00_pure_estimate)
set.seed(100)
sim00_pure_estimate[["fake_labels"]] <- sample(c("group_A", "group_B"), size = nrow(sim00_pure_estimate), replace = TRUE)
sim00_pure_estimate <- dplyr::relocate(sim00_pure_estimate, fake_labels, .after = "V1")
#### 3. Save data in qrds format
dir.create(file.path(proj_dir, "res"), showWarnings = FALSE)
qs::qsave(sim00_pure_estimate, file.path(proj_dir, "res", "sim00_pure_estimate.qs"))


#### 4. usethis::use_data()
sim_intraassay_sim00_pure_estimate <- sim00_pure_estimate
usethis::use_data(sim_intraassay_sim00_pure_estimate, overwrite = TRUE)
