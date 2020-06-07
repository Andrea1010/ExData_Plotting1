# loading the data 
library(dplyr)
df<-read.table("../household_power_consumption.txt",
               header = TRUE, sep=";", stringsAsFactors = F)
tbl<-as.tbl(df)
rm("df")

# filter out the data within 2007-02-01 to 02-02 
tbl<-mutate(tbl, Date=as.Date(Date,"%d/%m/%Y") )
sub_df<-filter(tbl,Date=="2007-02-01"|Date=="2007-02-02")
dim(sub_df)
rm("tbl")
datetime <- paste(as.Date(sub_df$Date), sub_df$Time)
sub_df$Datetime <- as.POSIXct(datetime)
lapply(sub_df,class)
sub_df[,3:9]<-lapply(sub_df[,3:9],as.numeric)

# plot2 
with(sub_df, plot (Datetime, Global_active_power, type = "l",
                   ylab="Global Active Power (kilowatts)", xlab=""))
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
