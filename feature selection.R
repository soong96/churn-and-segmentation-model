setwd("E:\\pd\\churn and segmentation\\Segmentation-and-Churn-Model")
inputData <- read.csv("E:\\pd\\churn and segmentation\\sql\\model 1.csv", stringsAsFactors=F)
str(inputData)
summary(inputData)

#glm
lin.mod <- glm(Topup_Value_3_Month_Avg  ~., data=inputData)
#lm
lin.mod <- lm(Topup_Value_3_Month_Avg  ~., data=inputData)
library(arm) # for 'display' function only

summary(lin.mod)
display(lin.mod)

#variable importance
library(caret)
varImp(lin.mod)


