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

# Zhang et al did their machine learning comparison by first restricting
# the data to the features in the gene signature "Stem.Sig"
# I was unable to find how the signature was GENERATED, only how it was loaded.
load(file.path(proj_dir, "data", "GM", "data", "sig", "Stem.Sig.Rdata"))
#### 3. Save data in qrds format
qs::qsave(training, file.path(proj_dir, "res", "training.qs"))
qs::qsave(validation, file.path(proj_dir, "res", "validation.qs"))
qs::qsave(test, file.path(proj_dir, "res", "test.qs"))
qs::qsave(Stem.Sig, file.path(proj_dir, "res", "Stem.Sig.qs"))



#### 4. usethis::use_data()
zhang2022_training <- training
usethis::use_data(zhang2022_training, overwrite = TRUE)

zhang2022_validation <- validation
usethis::use_data(zhang2022_validation, overwrite = TRUE)

zhang2022_test <- test
usethis::use_data(zhang2022_test, overwrite = TRUE)

zhang2022_Stem.Sig <- Stem.Sig
usethis::use_data(zhang2022_Stem.Sig, overwrite = TRUE)
