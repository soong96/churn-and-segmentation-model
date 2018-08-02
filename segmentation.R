# Set the Working Directory 
setwd("E:\\pd\\churn and segmentation\\Segmentation-and-Churn-Model")

library(RODBC)   
library(flexclust)

#train data
channel <- odbcConnect("presegmented", uid ="jsoong", pwd = "min1226" )
PreSegmented_Data <- sqlQuery(channel, 
                                      "select [MSISDN]
                                      ,[Product_ID]
                                      ,[Data_Fee_M1]
                                      ,[Data_Fee_M2]
                                      ,[Data_Fee_M3]
                                      ,[Data_Fee_Avg]
                                      ,[Local_Calls_Count_M1]
                                      ,[Local_Calls_Count_M2]
                                      ,[Local_Calls_Count_M3]
                                      ,[Local_Calls_Count_Avg]
                                      ,[OffNet_Voice_Minutes_Avg]
                                      ,[Roaming_Calls_Count_M2]
                                      ,[IDD_Voice_ASEAN_Minutes_M3]
                                      ,[OnNet_SMS_Count_Avg]
                                      ,[Topup_Value_M1]
                                      ,[Topup_Value_M2]
                                      ,[Topup_Value_M3]
                                      ,[Topup_Value_Avg_M1]
                                      ,[Topup_Value_Avg_M2]
                                      ,[Topup_Value_Avg_M3]
                                      ,[Avg_Topup_Value_Avg]
                                      FROM [JS_Testing].[dbo].[preprocessed_data]")
close(channel)

PreSegmented_Data

Model.features <- PreSegmented_Data[,c(-1:-2)]

Segment.Model.Normalized<-as.data.frame(Model.features)
Segment.Model.Normalized$Data_Fee_M1<-scale(Segment.Model.Normalized$Data_Fee_M1)
Segment.Model.Normalized$Data_Fee_M2<-scale(Segment.Model.Normalized$Data_Fee_M2)
Segment.Model.Normalized$Data_Fee_M3<-scale(Segment.Model.Normalized$Data_Fee_M3)
Segment.Model.Normalized$Data_Fee_Avg<-scale(Segment.Model.Normalized$Data_Fee_Avg)
Segment.Model.Normalized$Local_Calls_Count_M1<-scale(Segment.Model.Normalized$Local_Calls_Count_M1)
Segment.Model.Normalized$Local_Calls_Count_M2<-scale(Segment.Model.Normalized$Local_Calls_Count_M2)
Segment.Model.Normalized$Local_Calls_Count_M3<-scale(Segment.Model.Normalized$Local_Calls_Count_M3)
Segment.Model.Normalized$Local_Calls_Count_Avg<-scale(Segment.Model.Normalized$Local_Calls_Count_Avg)
Segment.Model.Normalized$OffNet_Voice_Minutes_Avg<-scale(Segment.Model.Normalized$OffNet_Voice_Minutes_Avg)
Segment.Model.Normalized$Roaming_Calls_Count_M2<-scale(Segment.Model.Normalized$Roaming_Calls_Count_M2)
Segment.Model.Normalized$IDD_Voice_ASEAN_Minutes_M3<-scale(Segment.Model.Normalized$IDD_Voice_ASEAN_Minutes_M3)
Segment.Model.Normalized$OnNet_SMS_Count_Avg<-scale(Segment.Model.Normalized$OnNet_SMS_Count_Avg)
Segment.Model.Normalized$Topup_Value_M1<-scale(Segment.Model.Normalized$Topup_Value_M1)
Segment.Model.Normalized$Topup_Value_M2<-scale(Segment.Model.Normalized$Topup_Value_M2)
Segment.Model.Normalized$Topup_Value_M3<-scale(Segment.Model.Normalized$Topup_Value_M3)
Segment.Model.Normalized$Topup_Value_Avg_M1<-scale(Segment.Model.Normalized$Topup_Value_Avg_M1)
Segment.Model.Normalized$Topup_Value_Avg_M2<-scale(Segment.Model.Normalized$Topup_Value_Avg_M2)
Segment.Model.Normalized$Topup_Value_Avg_M3<-scale(Segment.Model.Normalized$Topup_Value_Avg_M3)
Segment.Model.Normalized$Avg_Topup_Value_Avg<-scale(Segment.Model.Normalized$Avg_Topup_Value_Avg)

set.seed(2345)

#Function to find the best K(groups) for k Means
kmean_withinss <- function(k) {
  cluster <- kmeans(Segment.Model.Normalized, k)
  return (cluster$tot.withinss)
}

# Set maximum cluster 
max_k <-20 
# Run algorithm over a range of k 
wss <- sapply(2:max_k, kmean_withinss)
elbow <-data.frame(2:max_k, wss)
library(ggplot2)

# Plot the graph with gglop
ggplot(elbow, aes(x = X2.max_k, y = wss)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = seq(1, 20, by = 1))


#chose 6 for K, for best result
segmentation_model = kcca(Segment.Model.Normalized, k=6, kccaFamily("kmeans"))
segmentation_model 




save(segmentation_model, file = "E:\\pd\\churn and segmentation\\Segmentation-and-Churn-Model\\segmentation_model.rda")



# Running the Model using kmeans method (Unsupervised Learning - Classification)
load(file = "segmentation_model.rda") #Saved November Model M


# Scoring & Segment Tagging
set.seed(2345)
Segment.Distribution <-predict(segmentation_model,newdata=(Segment.Model.Normalized))
Segmented_Data <- cbind(PreSegmented_Data,Segment.Distribution)
Segmented_Data <- data.frame(Segmented_Data,row.names = NULL)
colnames(Segmented_Data)[dim(Segmented_Data)[2]]<-"Segment"


# Export data to database
channel_2 <- odbcConnect("segmented", uid ="jsoong", pwd = "min1226")
Insertdata<-sqlSave(channel_2,Segmented_Data,"dbo.segmented_data",rownames=FALSE,append=TRUE)
close(channel_2)

head(Current.Score.Combined)

#print(channel_2) -- track the connection whether in the same database 
#print(channel)
