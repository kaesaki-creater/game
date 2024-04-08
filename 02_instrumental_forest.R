## import libraries
library(grf)
library(devtools)
library(stats)
library(base)
library(foreign)
library(dplyr)

#Preprocessing processes, such as bootstrap sampling for selecting subsamples, were done before this R script.
#R version 4.2.1 was used. “grf”, version 2.3.2. was used.

## define folder
setwd("YOUR FOLDER")

for (i in 1:1000){
  n <- i+1000
  
  # define import and export file name
  # test_*: test data to use predict indivudual effect
  # train_*: train data to build model
  # predic_*: export file of individual effect
  # clate_*: export file of conditional local average treatment effect
  file.test <- sprintf("cf/test_%04d.csv", i) 
  file.train <- sprintf("cf/train_%04d.csv", i)
  file.predic <- sprintf("cf/predic_%04d.dta", i)
  file.clate <- sprintf("cf/clate_%04d.dta", i)
  # import csv file
  df_test <- read.csv(file.test)
  df_train <- read.csv(file.train)
  # check whether all variables are numeric in training and test sample
  sapply(df_train, class)
  sapply(df_test, class)

  # Train
  # define control variables
  X <- df_train %>%
    dplyr::select(age,gender,married2,married,divorce2,divorce,havechild2,havechild,singlechild2,singlechild,stu1,stu2,stu3,stu4,student,spouse,employee,self,part,unemployed,guess_1,guess_2,guess_3,guess_4,guess_5,pref_1,pref_2,pref_3,pref_4,pref_5,pref_6,pref_7,pref_8,pref_9,pref_10,pref_11,pref_12,pref_13,pref_14,pref_15,pref_16,pref_17,pref_18,pref_19,pref_20,pref_21,pref_22,pref_23,pref_24,pref_25,pref_26,pref_27,pref_28,pref_29,pref_30,pref_31,pref_32,pref_33,pref_34,pref_35,pref_36,pref_37,pref_38,pref_39,pref_40,pref_41,pref_42,pref_43,pref_44,pref_45,pref_46,pref_47,dairi2,njoin_member,njoin_member1,njoin_member2,njoin_member3,njoin_member4,njoin_member5,njoin_shop1,njoin_shop2,njoin_shop3,njoin_shop4,njoin_shop5,njoin_shop6,njoin_shop7,njoin_shop8,njoin_shop9,njoin_shop10,njoin_shop11,njoin_shop12,njoin_shop13,njoin_shop14,njoin_shop15,njoin_shop16,njoin_shop17,njoin_shop18,njoin_shop19,njoin_shop20,njoin_shop21,njoin_shop22,job4r_1,job4r_2,job4r_3,job4r_4,job4r_5,job4r_6,job4r_7,job4r_8,job4r_9,job4r_10,job4r_11,job4r_12,job4r_13,job4r_14,round,round_1,round_2,round_3,round_4,round_5)
  
  # define treatment dummy(choose from switch,PS5)
  W <- df_train$switch
  # define outcome variable(choose from k6,happiness,averageplaytime1)
  Y <- df_train$k6
  # define instrumental variable
  Z <- df_train$win  
  
  # set seed
  seed <- n
  set.seed(seed)
  
  # build instrumental forest model
  tau_forest <- instrumental_forest(X, Y, W, Z, seed = seed, num.trees = 10000, mtry = ncol(X)/3, min.node.size = 5)
  
  # Test
  # define control variables
  X_test <- df_test %>%
    dplyr::select(age,gender,married2,married,divorce2,divorce,havechild2,havechild,singlechild2,singlechild,stu1,stu2,stu3,stu4,student,spouse,employee,self,part,unemployed,guess_1,guess_2,guess_3,guess_4,guess_5,pref_1,pref_2,pref_3,pref_4,pref_5,pref_6,pref_7,pref_8,pref_9,pref_10,pref_11,pref_12,pref_13,pref_14,pref_15,pref_16,pref_17,pref_18,pref_19,pref_20,pref_21,pref_22,pref_23,pref_24,pref_25,pref_26,pref_27,pref_28,pref_29,pref_30,pref_31,pref_32,pref_33,pref_34,pref_35,pref_36,pref_37,pref_38,pref_39,pref_40,pref_41,pref_42,pref_43,pref_44,pref_45,pref_46,pref_47,dairi2,njoin_member,njoin_member1,njoin_member2,njoin_member3,njoin_member4,njoin_member5,njoin_shop1,njoin_shop2,njoin_shop3,njoin_shop4,njoin_shop5,njoin_shop6,njoin_shop7,njoin_shop8,njoin_shop9,njoin_shop10,njoin_shop11,njoin_shop12,njoin_shop13,njoin_shop14,njoin_shop15,njoin_shop16,njoin_shop17,njoin_shop18,njoin_shop19,njoin_shop20,njoin_shop21,njoin_shop22,job4r_1,job4r_2,job4r_3,job4r_4,job4r_5,job4r_6,job4r_7,job4r_8,job4r_9,job4r_10,job4r_11,job4r_12,job4r_13,job4r_14,round,round_1,round_2,round_3,round_4,round_5)
  # apply model to test sample
  tau_hat <- predict(tau_forest, X_test, estimate.variance=TRUE)
  
    # Estimate conditional local average treatment effect.
  clate <- as.data.frame(average_treatment_effect(tau_forest, target.sample = "all"))
  
  # export individual treatment effects
  write.dta(tau_hat, file.predic)
  write.dta(clate, file.clate)
}
