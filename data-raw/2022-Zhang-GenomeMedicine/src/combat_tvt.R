# From data-raw/2022-Zhang-GenomeMedicine/data/GM/Code/Model_Stem.Sig.R
pacman::p_load(stringr)
pacman::p_load(gridExtra)
pacman::p_load(sva)
pacman::p_load(caret)

# library(pROC)
# library(ROCit)
# library(future)
# library(e1071)
# library(doParallel)
# library(cancerclass)
for (i in 1:length(ios)) {
    if (i == 1) {
        cm <- colnames(ios[[1]])
    } else {
        cm <- intersect(cm, colnames(ios[[i]]))
    }
}
ios_bc <- lapply(ios, function(z) {
    return(z[, cm])
}) %>% do.call(rbind, .)
ios_bc <- cbind(rownames(ios_bc), ios_bc)
colnames(ios_bc)[1] <- "batch"
ios_bc$batch <- str_split_fixed(ios_bc$batch, "\\.", 2)[, 1]
rownames(ios_bc) <- ios_bc$ID
edata <- t(ios_bc[, 9:ncol(ios_bc)])
combat <- ComBat(
    dat = edata,
    batch = ios_bc$batch
)
combat <- as.data.frame(t(combat))
combat <- cbind(ios_bc[, 1:8], combat)
combat <- combat[!is.na(combat$response), ] ## remove patient with unknown response status



###########################################################################################################
#### ===============================3. Model Training and Validation with Stem.Sig======================####
###########################################################################################################


# 5 datasets for model training and validation
# "Bruan_RCC_pre_aPD1_combo_tpm" "Mariathasan_UC_pre_aPDL1_combo_tpm"  "Liu_SKCM_pre_aPD1_combo"  "Gide_SKCM_pre_combo" "Riaz_SKCM_pre_aPD1_combo"

# 5 independent datasets for model testing
# "Hugo_SKCM_pre_aPD1" "Van_SKCM_pre_aPD1" "Kim_GC_pre_aPD1" "Zhao_GBM_pre_aPD1" "Snyder_UC_pre_aPDL1"



data <- combat
grp <- unique(data$batch)
print(grp)
combat <- data[!data$batch %in% grp[c(3, 7, 8, 9, 10)], ] # comat for training and validation set


# 80% as training and 20% as testing
set.seed(13942)
trainIndex <- caret::createDataPartition(combat$response,
    p = .8, ## 80% training set; 20% validation set
    list = FALSE,
    times = 1
)

training <- combat[trainIndex, ]
validation <- combat[-trainIndex, ]
test <- data[data$batch %in% grp[c(3, 7, 8, 9, 10)], ]


training$response <- ifelse(training$response == "0", "NR", "R") %>% factor(., levels = c("R", "NR"))
validation$response <- ifelse(validation$response == "0", "NR", "R") %>% factor(., levels = c("R", "NR"))
test$response <- ifelse(test$response == "0", "NR", "R") %>% factor(., levels = c("R", "NR"))

training <- tibble::as_tibble(training)
validation <- tibble::as_tibble(validation)
test <- tibble::as_tibble(test)
