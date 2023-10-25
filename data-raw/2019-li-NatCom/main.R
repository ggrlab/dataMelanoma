# dataMelanoma::create_data_project("2019-li-NatCom")
proj_dir <- "data-raw/2019-li-NatCom/"


#### 1. Download data
datasets <- paste0("https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-019-12361-9/MediaObjects/41467_2019_12361_MOESM", 4:6, "_ESM.xlsx")
lapply(datasets, function(x) {
    download.file(
        url = x,
        destfile = file.path(proj_dir, "data", basename(x))
    )
})

#### 2. Read data
li_all_data <- sapply(basename(datasets), function(supplement_x) {
    sheets <- readxl::excel_sheets(file.path(proj_dir, "data", basename(supplement_x)))
    x <- sapply(sheets, function(x) readxl::read_excel(file.path(proj_dir, "data", supplement_x), sheet = x, na = "NA"))
    return(x[names(x) %in% c("patient characteristics", "baseline", "week 4", "week 6", "week 8")])
}, simplify = FALSE, USE.NAMES = TRUE)

names(li_all_data) <- c(
    "41467_2019_12361_MOESM4_ESM.xlsx" = "s1",
    "41467_2019_12361_MOESM5_ESM.xlsx" = "s2",
    "41467_2019_12361_MOESM6_ESM.xlsx" = "s3"
)[names(li_all_data)]

li_all_data$s3_nivo <- lapply(li_all_data$s3, function(x) {
    return(x[li_all_data[["s3"]][["patient characteristics"]][["Treatment"]] == "NIVOLUMAB", ])
})
li_all_data$s3_ever <- lapply(li_all_data$s3, function(x) {
    return(x[li_all_data[["s3"]][["patient characteristics"]][["Treatment"]] == "EVEROLIMUS", ])
})
li_all_data[["s3"]] <- NULL

li_all_data_measurements <- lapply(li_all_data, function(x) {
    x[["patient characteristics"]] <- NULL
    return(x)
})
li_all_pheno <- lapply(li_all_data, function(x) x[["patient characteristics"]])

studies_clearnames <- c(
    "s1" = "melanoma (nivolumab, phase1)",
    "s2" = "RCC (nivolumab, phase1)",
    "s3_nivo" = "RCC (nivolumab, phase3)",
    "s3_ever" = "RCC (everolimus, phase3)"
)
#### 3. Save data in qrds format
qs::qsave(studies_clearnames, file.path(proj_dir, "res", "studies_clearnames.qs"))

li_pheno <- li_all_pheno
qs::qsave(li_pheno, file.path(proj_dir, "res", "li_pheno.qs"))

li_measurements <- li_all_data_measurements
qs::qsave(li_measurements, file.path(proj_dir, "res", "li_measurements.qs"))


#### 4. usethis::use_data()
li2019_pheno <- li_all_pheno
usethis::use_data(li2019_pheno, overwrite = TRUE)
# a <- lapply(lapply(li2019_pheno, sinew::makeOxygen), cat)

li2019_measurements <- li_all_data_measurements
usethis::use_data(li2019_measurements, overwrite = TRUE)

li2019_studies_clearnames <- studies_clearnames
usethis::use_data(li2019_studies_clearnames, overwrite = TRUE)
