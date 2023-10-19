# dataMelanoma::create_data_project("2022-Zhang-GenomeMedicine")
proj_dir <- "data-raw/2022-Zhang-GenomeMedicine"


#### 1. Download data
# https://doi.org/10.6084/m9.figshare.17654633
single_example_file_from_downloaded <- file.path(proj_dir, "data", "GM", "data", "ios", "ios.Rdata")
if (!file.exists(single_example_file_from_downloaded)) {
    options(timeout = 10000)
    download.file(
        url = "https://figshare.com/ndownloader/files/34067072",
        destfile = file.path(proj_dir, "data", "zhang_figshare.zip")
    )
    unzip(
        zipfile = file.path(proj_dir, "data", "zhang_figshare.zip"),
        exdir = file.path(proj_dir, "data")
    )
}


#### 2. Read data
load(single_example_file_from_downloaded)
source(file.path(proj_dir, "src", "f01_combat_tvt.R"))
#### 3. Save data in qrds format
qs::qsave(training, file.path(proj_dir, "res", "training.qs"))
qs::qsave(validation, file.path(proj_dir, "res", "validation.qs"))
qs::qsave(test, file.path(proj_dir, "res", "test.qs"))



#### 4. usethis::use_data()
zhang2022_training <- training
usethis::use_data(zhang2022_training, overwrite = TRUE)

zhang2022_validation <- validation
usethis::use_data(zhang2022_validation, overwrite = TRUE)

zhang2022_test <- test
usethis::use_data(zhang2022_test, overwrite = TRUE)
