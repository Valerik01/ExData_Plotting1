## I have to set locale, because it will be cyrillic symbols on plot (days) 
#Sys.setlocale("LC_MESSAGES", 'en_GB.UTF-8')
#Sys.setenv(LANG = "en_US.UTF-8")
#Sys.setlocale("LC_TIME", "English")

filepath = "exdata.txt"
startdate <- as.Date("01/02/2007", "%d/%m/%Y")
enddate <- as.Date("02/02/2007", "%d/%m/%Y")

# Reading data from file
conn <- file(filepath, "r")
data <- read.table(conn, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
close(conn)

# Get our range
data$DateFormat <- as.Date(data$Date, "%d/%m/%Y")
data <- data[(data$DateFormat >= startdate)&(data$DateFormat <= enddate), ]
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "GMT")

# Plot 4

par(mfrow = c(2, 2))
with(data, plot(DateTime, Global_active_power, type = "l",  ylab = "Global Active Power", xlab = ""))
with(data, plot(DateTime, Voltage, type = "l",  ylab = "Voltage", xlab = "datetime"))
with(data, plot(DateTime, Sub_metering_1, type = "l",  ylab = "Energy sub metering", xlab = ""))
with(data, lines(DateTime, Sub_metering_2, col = "red"))
with(data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col = c("black", "red", "blue"), bty = "n", cex=0.7)
with(data, plot(DateTime, Global_reactive_power, type = "l",  ylab = "Global_reactive_power", xlab = "datetime"))

dev.copy(png, file = "plot4.png")
dev.off()