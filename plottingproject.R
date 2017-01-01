## Download File
URL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, destfile = "householdpowerdata")
unzip("householdpowerdata")
directory<- getwd()

## Read and Clean up data
table1<- read.table(file= "household_power_consumption.txt", header = TRUE,  sep= ";", na.strings = "?")
cleandata<-table1
cleandata<-na.omit(cleandata)
cleandata$Date<- as.Date(cleandata$Date, format= "%d/%m/%Y")
cleandata<- cleandata[cleandata$Date >= "2007-02-01" & cleandata$Date <= "2007-02-02",]
cleandata$Date<- as.factor(cleandata$Date)
cleandata$Date<- paste(cleandata$Date, cleandata$Time, sep="!")
head(cleandata$Date)
cleandata$Date<-strptime(cleandata$Date, format= "%Y-%m-%d!%H:%M:%S")



## cleandata$Date<-paste
cleandata$Time<- within (cleandata, {timestamp = strptime(paste(cleandata$Date, cleandata$Time), format = "%d/%m/%Y%H:%M:%S")})
## cleandata$Time<-strptime(cleandata$Time, format="%H:%M:%S")
## cleandata$Time<-strptime(Time, "%H:%M:%S")
## test<- strptime(cleandata$Time,"%T")


##Plot1

plot1<- funtion(){
        hist(cleandata$Global_active_power, col ="red", xlab = "Global Active Power (kilowatts)")
                dev.copy(png, file="plot1.png", width=480, height=480)
                dev.off()
                }
plot1()


## Plot 2

plot2<- function(){
        plot(cleandata$Date, cleandata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = "")
                dev.copy(png, file="plot2.png", width=480, height=480)
                dev.off()
}
plot2()




##Plot3

plot3<- function(){
        plot(cleandata$Date, cleandata$Sub_metering_1, type="l", col= "black", ylab="Energy sub metering", xlab = "")
        lines(cleandata$Date, cleandata$Sub_metering_2, type="l", col= "red")
        lines(cleandata$Date, cleandata$Sub_metering_3, type="l", col= "blue")
        dev.copy(png, file="plot2.png", width=480, height=480)
        dev.off()
}
plot3()


##Plot4

plot4<- function(){
        par(mfcol= c(2,2))
## Plot2 Added to Plot 4
        plot(cleandata$Date, cleandata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = "")
## Plot3 Added to Plot 4
        plot(cleandata$Date, cleandata$Sub_metering_1, type="l", col= "black", ylab="Energy sub metering", xlab = "")
        lines(cleandata$Date, cleandata$Sub_metering_2, type="l", col= "red")
        lines(cleandata$Date, cleandata$Sub_metering_3, type="l", col= "blue")
## New Plots for Voltage and Global Reactive Power Added to Plot 4
        plot(cleandata$Date, cleandata$Voltage, type="l", col= "black", ylab="Voltage", xlab = "datetime")
        plot(cleandata$Date, cleandata$Global_reactive_power, type="l", col= "black", ylab="Global_reactive_power", xlab = "datetime")
        dev.copy(png, file="plot2.png", width=480, height=480)
        dev.off()
}
plot4()



