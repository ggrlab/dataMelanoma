test_that("create_data_project", {
    create_data_project("removeme-test")
    unlink(file.path("data-raw", "removeme-test"), recursive = TRUE)
})
