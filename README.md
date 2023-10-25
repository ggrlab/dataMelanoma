
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dataMelanoma

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/dataMelanoma)](https://CRAN.R-project.org/package=dataMelanoma)
[![R-CMD-check](https://github.com/ggrlab/dataMelanoma/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ggrlab/dataMelanoma/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/ggrlab/dataMelanoma/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ggrlab/dataMelanoma?branch=master)
<!-- badges: end -->

The goal of dataMelanoma is to provides various melanoma datasets for
easy usage in R or general code projects.

## Installation

You can install the development version of dataMelanoma like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Example

# Thoughts

  - The package is motivated by <https://r-pkgs.org/data.html>
  - Some ideas were taken from
    <https://gitlab.spang-lab.de/glg58630/dataloading.lfs>
  - If I sometime decide to use zenodo:
    <https://github.com/ropenscilabs/deposits> or
    <https://github.com/eblondel/zen4R> (Probably rather `deposits`)

# How was this package created?

``` r
# for VSCode
install.packages("languageserver")
install.packages("devtools")
usethis::create_tidy_package("/home/gugl/clonedgit/ggrlab/dataMelanoma")
usethis::proj_activate("/home/gugl/clonedgit/ggrlab/dataMelanoma")
usethis::use_tidy_style(strict = TRUE)
usethis::use_git()
```

`usethis` tells you to envoke further github-related commands. There is
two ways to continue: 1. Create a personal access token (PAT) and use it
to authenticate with github 2. Manually push the package to github

Pushing manually works fine, but some advanced `usethis` commands won’t
work properly, therefore I will continue with the PAT.

``` r
#
usethis::create_github_token() # if done already, use "github token, ggrlab, PAT" password
gitcreds::gitcreds_set() # Then enter the freshly generated token
usethis::use_github(
    organisation = "ggrlab",
    private = FALSE,
    visibility = "public"
)
```

WARNING\!\!\! If an error occurs because e.g. the repository exists
already at github, use the following instead of `usethis::use_github()`:

``` bash
git branch -M main_devel
git remote add origin git@github.com:ggrlab/restrictedROC.git
git checkout main
git merge main_devel --allow-unrelated-histories
git push -u origin main
git branch --delete main_devel
```

``` r
usethis::use_tidy_github()
# # 2023-10-23: Do NOT use github action checks as it cannot cope with git lfs,
# # therefore always fails. Especially setup-r-dependencies fails because it tries
# # to install the packge, but the data is not available for lazy loading.
# # I actively removed
# #   .github/workflows/test-coverage.yaml
# #   .github/workflows/R-CMD-check.yaml
# #   .github/workflows/pkgdown.yaml
# #   .github/workflows/pr-commands.yaml
# usethis::use_tidy_github_actions()
# # overwrite tidy's default "check-full" with "check-standard"
# # to not run so many checks
# usethis::use_github_action("check-standard")
usethis::use_tidy_github_labels()
usethis::use_pkgdown_github_pages()
```

Additional information:

``` r
usethis::use_author(
    given = "Gunther",
    family = "Glehr",
    email = "gunthergl@gmx.net",
    role = c("aut", "cre"),
    comment = c("ORCID" = "0000-0002-1495-9162")
)
usethis::use_lifecycle()
usethis::use_news_md()
lintr::use_lintr(type = "tidyverse")
# Change file .lintr manually to:
# linters: linters_with_defaults(line_length_linter = line_length_linter(120),indentation_linter = indentation_linter(4)) # see vignette("lintr")
# encoding: "UTF-8"
```

precommit is a wonderful tool to check your code before committing it.

``` r
# https://lorenzwalthert.github.io/precommit/articles/precommit.html
# install.packages("precommit")
# bash::$ conda deactivate
# bash::$ pip3 install pre-commit
precommit::install_precommit()
precommit::use_precommit()
## Use pre-commit-config.yaml from restrictedROC
```

Before committing: `pre-commit install --hook-type pre-push`, then
commit.

Used packages:

``` r
usethis::use_package("devtools")
usethis::use_package("lifecycle")
precommit::snippet_generate("additional-deps-roxygenize")
```

Packages used within the data-raw scripts:

``` r
usethis::use_package("dplyr", type = "Suggests")
usethis::use_package("tibble", type = "Suggests")
usethis::use_package("qs", type = "Suggests")
usethis::use_package("usethis", type = "Suggests")
usethis::use_package("readxl", type = "Suggests")
usethis::use_package("pacman", type = "Suggests")
usethis::use_package("stringr", type = "Suggests")
usethis::use_package("gridExtra", type = "Suggests")
usethis::use_package("sva", type = "Suggests")
usethis::use_package("caret", type = "Suggests")
usethis::use_package("data.table", type = "Suggests")
```

Set up git-lfs

``` bash
git lfs install
git lfs track "*.rda"
git add .gitattributes
```

Added LazyDataCompression to DESCRIPTION:

    LazyDataCompression: bzip2

## How to add or reproduce datasets

### Quickstart

Create a new project with `create_data_project()`. This will create a
new folder in `data-raw/` and populate it with a `main.R` script
containing a very basic layout of code which you can populate.

``` r
dataMelanoma::create_data_project("2022-Lozano-NatMed")
```

Now modify `data-raw/2022-Lozano-NatMed/main.R`. If you need more
complicated scripts or additional functions, stratify them within
`data-raw/2022-Lozano-NatMed/src/` and
`data-raw/2022-Lozano-NatMed/src/_functions/`.

### Slightly more detailed

To add or reproduce datasets you need the raw datafiles. All final
datasets can be found under `data/<datasetname>.rda`. Those files
**must** be generated by the scripts in `data-raw` using
`usethis::use_data()`. Inside `data-raw` are folders, in best case
logically separated.

I usually term them with `<year>-<FirstAuthorLASTname>-<Journal>` where
year refers to the year in the respective citation. In the following I
refer to such an example folder by `rawdir_dataset`.

An example of a dataset is `data-raw/2022-Lozano-NatMed/`. Each
`data-raw` project must have the following structure:

``` bash
data-raw/2022-Lozano-NatMed/
    ├── main.R  # The main script to reproduce the data, ALL code must be called from here
    ├── src/    # Here is the code to reproduce the data stored in res/
    │   ├── _functions/             # Functions used 
    │   ├── f01_example.R           # Code to reproduce the data
    │   ├── ...                         
    │   └── f99_finalCodePart.R
    ├── data/   # Here is the actual raw data
    └── res/    # The final data files
```

Scripts must access data by their full path relative to the main
`datamelanoma`-package directory:

``` r
proj_dir <- "data-raw/2022-Lozano-NatMed/" # The current data-raw, dataset folder
my_data <- read.csv(file.path(proj_dir, "data/rawData/example.csv"))

# if there are subfolders in rawdata
my_data <- read.csv(file.path(proj_dir, "data/rawData/folderXY/example2.csv"))
```

Inside git, **no raw data** should be included. Usually, the data is
online somewhere already, so include code to download the data. If the
data is not online, it should be stored in e.g. zenodo, then the code to
download it from there should be included.

In the end, the complete dataset must be reproducible by calling
`main.R` within each `data-raw` folder.

# How to add information

``` r
# Use pre-commits to check your code before committing it
remotes::install_github("lorenzwalthert/precommit")
precommit::install_precommit()
precommit::use_precommit()

# Increase the versions manually
# Add a note to NEWS.md


# Add new functionality and document it
# During development, have a clean R environment and run devtools::load_all() to load the current status of the package
devtools::load_all()

# After adding new functionality, run devtools::check() to update the documentation
devtools::check()
devtools::document()

# Vignettes are a great way to document your package
# Add a new vignette by running
usethis::use_vignette("vignette_name")
# Change the vignette in vignettes/vignette_name.Rmd
# Build the vignette by running
devtools::build_vignettes() # This also installs the package

# Articles
# Instead of a vignette, you can create an article, which is a term used by
# pkgdown for a vignette-like .Rmd document that is not shipped with the package,
# but that appears only in the website.
usethis::use_article("article_name")
# Further arguments of devtools::build_site() are forwarded to pkgdown::build_site():
# https://pkgdown.r-lib.org/reference/build_site.html
devtools::build_site()
devtools::build_site(devel = TRUE, lazy = TRUE) # Use this for faster iteration during development

devtools::build_readme() # This updates the README.md file from the README.Rmd
```

  - Disable pre-commit for a single commit: `git commit . -m 'quick fix'
    --no-verify`
