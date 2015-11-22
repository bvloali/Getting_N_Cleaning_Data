##Step 0, reading data.

xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt")
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
feature<-read.table("UCI HAR Dataset/features.txt",colClasses = "character")

##Step 1, merging data into one complete data set.

x<-c(-1,"Subject")
y<-c(0,"Activity")
header<-rbind(x,y,feature)
fulltrain<-cbind(subjecttrain,ytrain,xtrain)
fulltest<-cbind(subjecttest,ytest,xtest)
merged<-rbind(fulltrain,fulltest)

## Step 4, labling the data set with descriptive variable names.

colnames(merged)<-header[,"V2"]

##Step 3, replacing with descriptive activity label

merged$Activity<-as.character(merged$Activity)
merged$Activity[merged$Activity=="1"]<-"Walking"
merged$Activity[merged$Activity=="2"]<-"Walking Upstairs"
merged$Activity[merged$Activity=="3"]<-"Walking Downstairs"
merged$Activity[merged$Activity=="4"]<-"Sitting"
merged$Activity[merged$Activity=="5"]<-"Standing"
merged$Activity[merged$Activity=="6"]<-"Laying"

## Step 2, extracting only the measurements on the mean and standard deviation

mean_std<-merged[,grep("Subject|Activity|mean|std",names(merged))]

## Step 5, creating a second data set with the average of each variable for each activity and each subject.

output<-aggregate(mean_std[,3:81],list(mean_std$Subject,mean_std$Activity),mean)
write.table(output,file = "Output.txt",row.names = FALSE)
