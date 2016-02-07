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

## Open graphics device
png("plot1.png", width = 480, height = 480, units = "px")

## Draw the histogram
hist(as.numeric(df$Global_active_power), col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

## Close file
dev.off()