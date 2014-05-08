# Plot1.R
# R Code for Exploratory Data Analysis Class, JHU via Coursera
# author:  Leif Ulstrup, 05-08-2014
# Assignment #1, due 05-11-14

# This program reads a data file from the UC Irvine Machine Learning archives
# fila name household_power_consumption.txt

# this program plots analysis of the data per the assignment
#
# a subset of the data is used  2007-02-01 to 2007-02-02  (the original file have > 2m records and samples every minute)
#  the character '?' is used for Null readings (need to set na.strings=c("?") in read.table function)

# use colClasses to speed processing  per JHU bioninformatics web page recommendations

# to speed processing you need to skip to row 66636 and only ingest 2 days worth of data = (24 hours * 60 minutes) *2 = 2880


powerData <- read.table("household_power_consumption.txt", 
	skip=66636, nrows= 2880, 
	header = TRUE, sep = ";", 
	colClasses = c("Date" = "character", "Time"="character", "Global_active_power"="numeric", "Global_reactive_power"="numeric", "Voltage"="numeric", "Global_intensity"="numeric", "Sub_metering_1"="numeric", "Sub_metering_2"="numeric", "Sub_metering_3"="numeric"), na.strings=c("?"))

theDates <- as.Date(strptime(powerData$Date, "%d/%m/%Y"))

# subset is not needed if we use skip and nrows in read.table()
# analysisSubset <- subset(powerData, (theDates >= "2007-02-01" & theDates <= "2007-02-02"))

dateAndTime <- strptime(paste(analysisSubset$Date, analysisSubset$Time), "%d/%m/%Y %H:%M:%S")

powerData <- cbind(dateAndTime, powerData)

theColumnNames <- c("datetime", "Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

colnames(powerData) <- theColumnNames

# prepare the plots per the assignment

# Plot 1
png("plot1.png", width = 480, height = 480)
hist(powerData$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
#dev.copy(png, file="plot1.png", width = 480, height = 480)
dev.off()
