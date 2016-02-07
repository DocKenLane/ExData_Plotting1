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
png("plot2.png", width = 480, height = 480, units = "px")

## Create the plot without points
plot(dateTime, df$Global_active_power, type = "n", xlab = NA, main = NA,
     ylab = "Global Active Power (kilowatts)")

## Draw the lines
lines(dateTime, df$Global_active_power)

## Close file
dev.off()