# Q.2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#     (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
#     a plot answering this question.
# Ans. According to the bar plot, the emissions have decreased from 1999 to 2008,
#      but it shows an increasing-decreasing pattern as is evident from the plot.

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

# Sub-setting the NEI data to find Baltimore's PM2.5 emissions
Baltimore_NEI <- NEI[NEI$fips=="24510",]

#Aggregating the emissions in Baltimore by year
Baltimore_Emissions <- aggregate(Emissions ~ year, Baltimore_NEI, sum)

# Opening a png device
png("plot2.png", width=480, height=480, units="px")

# Creating a bar plot
barplot(Baltimore_Emissions$Emissions, names.arg=Baltimore_Emissions$year, xlab="Year", ylab=expression("PM"[2.5]*" Emissions (in tons)"), col = "lightpink3", main=expression("Yearly PM"[2.5]*" Emissions In Baltimore"))

# Closing the png device
dev.off()