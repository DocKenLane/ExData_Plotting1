## Set up names
archive <-"exdata-data-household_power_consumption.zip" 
filename <- "household_power_consumption.txt"

## Read all data into dataframe
df <- read.csv(unz(archive, filename), header = TRUE, sep = ";", as.is = c(TRUE))

## Locate target days and cast away the rest
day1 <- sapply(df$Date, grepl, "1/2/2007")
day2 <- sapply(df$Date, grepl, "2/2/2007")
days <- day1 | day2
df <- df[days, ]

## Create vector with date and time combined
dateTime <- strptime(paste(df$Date, df$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

## Open graphics device
png("plot3.png", width = 480, height = 480, units = "px")

## Create the plot without points
plot(dateTime,df$Sub_metering_1, type = "n",  xlab = NA, main = NA,
          ylab = "Energy sub metering")

## Plot lines in appropriate color
lines(dateTime,df$Sub_metering_1, col = "black")
lines(dateTime,df$Sub_metering_2, col = "red")
lines(dateTime,df$Sub_metering_3, col = "blue")

## Right-justifying a set of labels: thanks to Uwe Ligges
line_color <- c("black", "red", "blue")
temp <- legend("topright", legend = c(" ", " ", " "),
               text.width = strwidth("Sub_metering_1"),
               lty = c(1, 1, 1), col = line_color, xjust = 1, yjust = 1)
text(temp$rect$left + temp$rect$w, temp$text$y,
     c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pos = 2)

## Close file
dev.off()