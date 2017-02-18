## I have to set locale, because it will be cyrillic symbols on plot (days) 
# Sys.setlocale("LC_MESSAGES", 'en_GB.UTF-8')
# Sys.setenv(LANG = "en_US.UTF-8")
# Sys.setlocale("LC_TIME", "English")

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

# Plot 2

with(data, plot(DateTime, Global_active_power, type = "l",  ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.copy(png, file = "plot2.png")
dev.off()