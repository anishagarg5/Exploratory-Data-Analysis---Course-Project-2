# Q.1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#     Using the base plotting system, make a plot showing the total PM2.5 emission from 
#     all sources for each of the years 1999, 2002, 2005, and 2008.
# Ans. From the barplot, we can see that the emissions have decreased from 1999 to 2008.

# Downloading the data
getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "NEI_data.zip"
download.file(url, file, method = "curl", mode = "wb")
unzip(file)

# Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Doing basic QC checks on the data
dir()
## files exist

str(NEI)
str(SCC)
unique(NEI$year)
## 1999 2002 2005 2008

# Aggregating the emissions by year from the NEI data
emyr <- aggregate(Emissions ~ year, NEI, sum)

# Opening a png device
png("plot1.png", width=480, height=480, units="px")

# Creating a bar plot
barplot((emyr$Emissions)/10^6, names.arg=emyr$year, xlab="Year", ylab=expression("PM"[2.5]*" Emissions (in million tons)"), col = "darkseagreen", main=expression("Yearly PM"[2.5]*" Emissions In US From All Sources"))

# Closing the png device
dev.off()