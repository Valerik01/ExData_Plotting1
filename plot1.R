filepath = "exdata.txt"
startdate <- as.Date("01/02/2007", "%d/%m/%Y")
enddate <- as.Date("02/02/2007", "%d/%m/%Y")

# Reading data from file
conn <- file(filepath, "r")
data <- read.table(conn, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
close(conn)

# Get our range
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- data[(data$Date >= startdate)&(data$Date <= enddate), ]

# Plot 1
with(data, hist(Global_active_power, main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red"))
dev.copy(png, file = "plot1.png")
dev.off()