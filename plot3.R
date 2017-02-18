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

# Plot 3

with(data, plot(DateTime, Sub_metering_1, type = "l",  ylab = "Energy sub metering", xlab = ""))
with(data, lines(DateTime, Sub_metering_2, col = "red"))
with(data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col = c("black", "red", "blue"))

dev.copy(png, file = "plot3.png")
dev.off()