#break down segment 4 into 3 more subsegments

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
                              ,[Local_Voice_Minutes_M1]
                              ,[Local_Voice_Minutes_M2]
                              ,[Local_Voice_Minutes_M3]
                              ,[Local_Voice_Minutes_Avg]
                              ,[OffNet_Calls_Count_Avg]
                              ,[OnNet_Calls_Count_M1]
                              ,[OnNet_Calls_Count_M2]
                              ,[IDD_Calls_ASEAN_Count_M1]
                              ,[IDD_Calls_ASEAN_Count_M2]
                              ,[IDD_Calls_ASEAN_Count_M3]
                              ,[IDD_Calls_ASEAN_Count_Avg]
                              ,[Local_SMS_Count_Avg]
                              ,[OffNet_SMS_Count_Avg]
                              ,[IDD_SMS_Count_M1]
                              ,[IDD_SMS_Count_M2]
                              ,[IDD_SMS_Count_M3]
                              ,[Avg_Balance_Before_Topup_M1]
                              ,[Avg_Balance_Before_Topup_M2]
                              ,[Avg_Balance_Before_Topup_M3]
                              ,[Avg_Balance_Before_Topup_Avg]
                              ,[Topup_Value_Avg_M1]
                              ,[Topup_Value_Avg_M2]
                              ,[Topup_Value_Avg_M3]
                              ,[Avg_Topup_Value_Avg]
                              FROM 
                              (SELECT a.*,b.Segment FROM(
                              
                              (SELECT [MSISDN]
                              ,[Product_ID]
                              ,[Bundle_ID]
                              ,[Gender]
                              ,[Age]
                              ,[District]
                              ,[Activation_Date]
                              ,[Active_Months]
                              ,[M1_STATUS]
                              ,[M2_STATUS]
                              ,[M3_STATUS]
                              ,[Data_USAGE_MB_M1]
                              ,[Data_USAGE_MB_M2]
                              ,[Data_USAGE_MB_M3]
                              ,[Data_Usage_MB_Avg]
                              ,[Data_Fee_M1]
                              ,[Data_Fee_M2]
                              ,[Data_Fee_M3]
                              ,[Data_Fee_Avg]
                              ,[Local_Calls_Count_M1]
                              ,[Local_Calls_Count_M2]
                              ,[Local_Calls_Count_M3]
                              ,[Local_Calls_Count_Avg]
                              ,[Local_Voice_Fee_M1]
                              ,[Local_Voice_Fee_M2]
                              ,[Local_Voice_Fee_M3]
                              ,[Local_Voice_Fee_Avg]
                              ,[Local_Voice_Minutes_M1]
                              ,[Local_Voice_Minutes_M2]
                              ,[Local_Voice_Minutes_M3]
                              ,[Local_Voice_Minutes_Avg]
                              ,[OnNet_Calls_Count_M1]
                              ,[OnNet_Calls_Count_M2]
                              ,[OnNet_Calls_Count_M3]
                              ,[OnNet_Calls_Count_Avg]
                              ,[OnNet_Voice_Fee_M1]
                              ,[OnNet_Voice_Fee_M2]
                              ,[OnNet_Voice_Fee_M3]
                              ,[OnNet_Voice_Fee_Avg]
                              ,[OnNet_Voice_Minutes_M1]
                              ,[OnNet_Voice_Minutes_M2]
                              ,[OnNet_Voice_Minutes_M3]
                              ,[OnNet_Voice_Minutes_Avg]
                              ,[OffNet_Calls_Count_M1]
                              ,[OffNet_Calls_Count_M2]
                              ,[OffNet_Calls_Count_M3]
                              ,[OffNet_Calls_Count_Avg]
                              ,[OffNet_Voice_Fee_M1]
                              ,[OffNet_Voice_Fee_M2]
                              ,[OffNet_Voice_Fee_M3]
                              ,[OffNet_Voice_Fee_Avg]
                              ,[OffNet_Voice_Minutes_M1]
                              ,[OffNet_Voice_Minutes_M2]
                              ,[OffNet_Voice_Minutes_M3]
                              ,[OffNet_Voice_Minutes_Avg]
                              ,[OnNet_Incoming_Calls_Count_M1]
                              ,[OnNet_Incoming_Calls_Count_M2]
                              ,[OnNet_Incoming_Calls_Count_M3]
                              ,[OnNet_Incoming_Calls_Count_Avg]
                              ,[OnNet_Incoming_Voice_Minutes_M1]
                              ,[OnNet_Incoming_Voice_Minutes_M2]
                              ,[OnNet_Incoming_Voice_Minutes_M3]
                              ,[OnNet_Incoming_Voice_Minutes_Avg]
                              ,[OffNet_Incoming_Calls_Count_M1]
                              ,[OffNet_Incoming_Calls_Count_M2]
                              ,[OffNet_Incoming_Calls_Count_M3]
                              ,[OffNet_Incoming_Calls_Count_Avg]
                              ,[OffNet_Incoming_Voice_Minutes_M1]
                              ,[OffNet_Incoming_Voice_Minutes_M2]
                              ,[OffNet_Incoming_Voice_Minutes_M3]
                              ,[OffNet_Incoming_Voice_Minutes_Avg]
                              ,[Roaming_Calls_Count_M1]
                              ,[Roaming_Calls_Count_M2]
                              ,[Roaming_Calls_Count_M3]
                              ,[Roaming_Calls_Count_Avg]
                              ,[Roaming_Voice_Fee_M1]
                              ,[Roaming_Voice_Fee_M2]
                              ,[Roaming_Voice_Fee_M3]
                              ,[Roaming_Voice_Fee_Avg]
                              ,[Roaming_Voice_Minutes_M1]
                              ,[Roaming_Voice_Minutes_M2]
                              ,[Roaming_Voice_Minutes_M3]
                              ,[Roaming_Voice_Minutes_Avg]
                              ,[IDD_Calls_Count_M1]
                              ,[IDD_Calls_Count_M2]
                              ,[IDD_Calls_Count_M3]
                              ,[IDD_Calls_Count_Avg]
                              ,[IDD_Voice_Fee_M1]
                              ,[IDD_Voice_Fee_M2]
                              ,[IDD_Voice_Fee_M3]
                              ,[IDD_Voice_Fee_Avg]
                              ,[IDD_Voice_Minutes_M1]
                              ,[IDD_Voice_Minutes_M2]
                              ,[IDD_Voice_Minutes_M3]
                              ,[IDD_Voice_Minutes_Avg]
                              ,[IDD_00_Calls_Count_M1]
                              ,[IDD_00_Calls_Count_M2]
                              ,[IDD_00_Calls_Count_M3]
                              ,[IDD_00_Calls_Count_Avg]
                              ,[IDD_00_Voice_Fee_M1]
                              ,[IDD_00_Voice_Fee_M2]
                              ,[IDD_00_Voice_Fee_M3]
                              ,[IDD_00_Voice_Fee_Avg]
                              ,[IDD_00_Voice_Minutes_M1]
                              ,[IDD_00_Voice_Minutes_M2]
                              ,[IDD_00_Voice_Minutes_M3]
                              ,[IDD_00_Voice_Minutes_Avg]
                              ,[IDD_89_Calls_Count_M1]
                              ,[IDD_89_Calls_Count_M2]
                              ,[IDD_89_Calls_Count_M3]
                              ,[IDD_89_Calls_Count_Avg]
                              ,[IDD_89_Voice_Fee_M1]
                              ,[IDD_89_Voice_Fee_M2]
                              ,[IDD_89_Voice_Fee_M3]
                              ,[IDD_89_Voice_Fee_Avg]
                              ,[IDD_89_Voice_Minutes_M1]
                              ,[IDD_89_Voice_Minutes_M2]
                              ,[IDD_89_Voice_Minutes_M3]
                              ,[IDD_89_Voice_Minutes_Avg]
                              ,[IDD_98_Calls_Count_M1]
                              ,[IDD_98_Calls_Count_M2]
                              ,[IDD_98_Calls_Count_M3]
                              ,[IDD_98_Calls_Count_Avg]
                              ,[IDD_98_Voice_Fee_M1]
                              ,[IDD_98_Voice_Fee_M2]
                              ,[IDD_98_Voice_Fee_M3]
                              ,[IDD_98_Voice_Fee_Avg]
                              ,[IDD_98_Voice_Minutes_M1]
                              ,[IDD_98_Voice_Minutes_M2]
                              ,[IDD_98_Voice_Minutes_M3]
                              ,[IDD_98_Voice_Minutes_Avg]
                              ,[IDD_Calls_ASEAN_Count_M1]
                              ,[IDD_Calls_ASEAN_Count_M2]
                              ,[IDD_Calls_ASEAN_Count_M3]
                              ,[IDD_Calls_ASEAN_Count_Avg]
                              ,[IDD_Voice_ASEAN_Fee_M1]
                              ,[IDD_Voice_ASEAN_Fee_M2]
                              ,[IDD_Voice_ASEAN_Fee_M3]
                              ,[IDD_Voice_ASEAN_Fee_Avg]
                              ,[IDD_Voice_ASEAN_Minutes_M1]
                              ,[IDD_Voice_ASEAN_Minutes_M2]
                              ,[IDD_Voice_ASEAN_Minutes_M3]
                              ,[IDD_Voice_ASEAN_Minutes_Avg]
                              ,[Local_SMS_Count_M1]
                              ,[Local_SMS_Count_M2]
                              ,[Local_SMS_Count_M3]
                              ,[Local_SMS_Count_Avg]
                              ,[Local_SMS_Fee_M1]
                              ,[Local_SMS_Fee_M2]
                              ,[Local_SMS_Fee_M3]
                              ,[Local_SMS_Fee_Avg]
                              ,[OnNet_SMS_Fee_M1]
                              ,[OnNet_SMS_Fee_M2]
                              ,[OnNet_SMS_Fee_M3]
                              ,[OnNet_SMS_Fee_Avg]
                              ,[OnNet_SMS_Count_M1]
                              ,[OnNet_SMS_Count_M2]
                              ,[OnNet_SMS_Count_M3]
                              ,[OnNet_SMS_Count_Avg]
                              ,[OffNet_SMS_Fee_M1]
                              ,[OffNet_SMS_Fee_M2]
                              ,[OffNet_SMS_Fee_M3]
                              ,[OffNet_SMS_Fee_Avg]
                              ,[OffNet_SMS_Count_M1]
                              ,[OffNet_SMS_Count_M2]
                              ,[OffNet_SMS_Count_M3]
                              ,[OffNet_SMS_Count_Avg]
                              ,[IDD_SMS_Fee_M1]
                              ,[IDD_SMS_Fee_M2]
                              ,[IDD_SMS_Fee_M3]
                              ,[IDD_SMS_Fee_Avg]
                              ,[IDD_SMS_Count_M1]
                              ,[IDD_SMS_Count_M2]
                              ,[IDD_SMS_Count_M3]
                              ,[IDD_SMS_Count_Avg]
                              ,[Roam_SMS_Fee_M1]
                              ,[Roam_SMS_Fee_M2]
                              ,[Roam_SMS_Fee_M3]
                              ,[Roam_SMS_Fee_Avg]
                              ,[Roam_SMS_Count_M1]
                              ,[Roam_SMS_Count_M2]
                              ,[Roam_SMS_Count_M3]
                              ,[Roam_SMS_Count_Avg]
                              ,[SMS_Fee_M1]
                              ,[SMS_Fee_M2]
                              ,[SMS_Fee_M3]
                              ,[SMS_Fee_Avg]
                              ,[SMS_Count_M1]
                              ,[SMS_Count_M2]
                              ,[SMS_Count_M3]
                              ,[SMS_Count_Avg]
                              ,[Incoming_SMS_Fee_M1]
                              ,[Incoming_SMS_Fee_M2]
                              ,[Incoming_SMS_Fee_M3]
                              ,[Incoming_SMS_Fee_Avg]
                              ,[Incoming_SMS_Count_M1]
                              ,[Incoming_SMS_Count_M2]
                              ,[Incoming_SMS_Count_M3]
                              ,[Incoming_SMS_Count_Avg]
                              ,[Topup_Value_M1]
                              ,[Topup_Value_M2]
                              ,[Topup_Value_M3]
                              ,[Topup_Value_3_Month_Avg]
                              ,[Topup_Value_Avg_M1]
                              ,[Topup_Value_Avg_M2]
                              ,[Topup_Value_Avg_M3]
                              ,[Avg_Topup_Value_Avg]
                              ,[Avg_Balance_Before_Topup_M1]
                              ,[Avg_Balance_Before_Topup_M2]
                              ,[Avg_Balance_Before_Topup_M3]
                              ,[Avg_Balance_Before_Topup_Avg]
                              ,[Topup_Count_M1]
                              ,[Topup_Count_M2]
                              ,[Topup_Count_M3]
                              ,[Topup_Count_Avg]
                              ,[Topup_Days_Range_M1]
                              ,[Topup_Days_Range_M2]
                              ,[Topup_Days_Range_M3]
                              ,[Topup_Days_Range_Avg]
                              ,[Bundle_Amount_M1]
                              ,[Bundle_Amount_M2]
                              ,[Bundle_Amount_M3]
                              ,[Bundle_Amount_Avg]
                              ,[Bundle_Count_M1]
                              ,[Bundle_Count_M2]
                              ,[Bundle_Count_M3]
                              ,[Bundle_Count_Avg]
                              ,[Yes Zoom Revenue_M1]
                              ,[Yes Zoom Revenue_M2]
                              ,[Yes Zoom Revenue_M3]
                              ,[Yes Zoom Revenue_Avg]
                              FROM [JS_Testing].[dbo].[preprocessed_data])a
                              left join
                              (SELECT [MSISDN]
                              ,[Segment]
                              FROM [JS_Testing].[dbo].segmented_data)b
                              on a.MSISDN = b.MSISDN
                              )
                              where b.Segment = 4)a")
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
Segment.Model.Normalized$Local_Voice_Minutes_M1<-scale(Segment.Model.Normalized$Local_Voice_Minutes_M1)
Segment.Model.Normalized$Local_Voice_Minutes_M2<-scale(Segment.Model.Normalized$Local_Voice_Minutes_M2)
Segment.Model.Normalized$Local_Voice_Minutes_M3<-scale(Segment.Model.Normalized$Local_Voice_Minutes_M3)
Segment.Model.Normalized$Local_Voice_Minutes_Avg<-scale(Segment.Model.Normalized$Local_Voice_Minutes_Avg)
Segment.Model.Normalized$OffNet_Calls_Count_Avg<-scale(Segment.Model.Normalized$OffNet_Calls_Count_Avg)
Segment.Model.Normalized$OnNet_Calls_Count_M1<-scale(Segment.Model.Normalized$OnNet_Calls_Count_M1)
Segment.Model.Normalized$OnNet_Calls_Count_M2<-scale(Segment.Model.Normalized$OnNet_Calls_Count_M2)
Segment.Model.Normalized$IDD_Calls_ASEAN_Count_M1<-scale(Segment.Model.Normalized$IDD_Calls_ASEAN_Count_M1)
Segment.Model.Normalized$IDD_Calls_ASEAN_Count_M2<-scale(Segment.Model.Normalized$IDD_Calls_ASEAN_Count_M2)
Segment.Model.Normalized$IDD_Calls_ASEAN_Count_M3<-scale(Segment.Model.Normalized$IDD_Calls_ASEAN_Count_M3)
Segment.Model.Normalized$IDD_Calls_ASEAN_Count_Avg<-scale(Segment.Model.Normalized$IDD_Calls_ASEAN_Count_Avg)
Segment.Model.Normalized$Local_SMS_Count_Avg<-scale(Segment.Model.Normalized$Local_SMS_Count_Avg)
Segment.Model.Normalized$OffNet_SMS_Count_Avg<-scale(Segment.Model.Normalized$OffNet_SMS_Count_Avg)
Segment.Model.Normalized$IDD_SMS_Count_M1<-scale(Segment.Model.Normalized$IDD_SMS_Count_M1)
Segment.Model.Normalized$IDD_SMS_Count_M2<-scale(Segment.Model.Normalized$IDD_SMS_Count_M2)
Segment.Model.Normalized$IDD_SMS_Count_M3<-scale(Segment.Model.Normalized$IDD_SMS_Count_M3)
Segment.Model.Normalized$Avg_Balance_Before_Topup_M1<-scale(Segment.Model.Normalized$Avg_Balance_Before_Topup_M1)
Segment.Model.Normalized$Avg_Balance_Before_Topup_M2<-scale(Segment.Model.Normalized$Avg_Balance_Before_Topup_M2)
Segment.Model.Normalized$Avg_Balance_Before_Topup_M3<-scale(Segment.Model.Normalized$Avg_Balance_Before_Topup_M3)
Segment.Model.Normalized$Avg_Balance_Before_Topup_Avg<-scale(Segment.Model.Normalized$Avg_Balance_Before_Topup_Avg)
Segment.Model.Normalized$Topup_Value_Avg_M1<-scale(Segment.Model.Normalized$Topup_Value_Avg_M1)
Segment.Model.Normalized$Topup_Value_Avg_M2<-scale(Segment.Model.Normalized$Topup_Value_Avg_M2)
Segment.Model.Normalized$Topup_Value_Avg_M3<-scale(Segment.Model.Normalized$Topup_Value_Avg_M3)
Segment.Model.Normalized$Avg_Topup_Value_Avg<-scale(Segment.Model.Normalized$Avg_Topup_Value_Avg)


set.seed(2345)
#chose 6 for K, for best result
segmentation_model = cclust(Segment.Model.Normalized, k=3,dist = "manhattan", method = ("kmeans"))
summary(segmentation_model )




save(segmentation_model, file = "E:\\pd\\churn and segmentation\\Segmentation-and-Churn-Model\\segmentation_model.rda")



# Running the Model using kmeans method (Unsupervised Learning - Classification)
load(file = "segmentation_model.rda") #Saved November Model M


# Scoring & Segment Tagging

set.seed(2345)
Segment.Distribution <-predict(segmentation_model,newdata=(Segment.Model.Normalized))
Segmented_Data <- cbind(PreSegmented_Data[1],Segment.Distribution)
Segmented_Data <- data.frame(Segmented_Data,row.names = NULL)
colnames(Segmented_Data)[dim(Segmented_Data)[2]]<-"Segment"


# Export data to database
Segmented_Data[1:2]
channel <- odbcConnect("segmented", uid ="jsoong", pwd = "min1226")
sqlSave(channel,Segmented_Data[1:2],"sub_segmented_data",append = TRUE)
close(channel)
