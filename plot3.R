# Q.3 Of the four types of sources indicated by the type(point, nonpoint, onroad, 
#     non-road) variable, which of these four sources have seen decreases in emissions 
#     from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
#     1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# Ans. From the plot, we can see that there is a decrease in all types, except
#      point. However, total emissions from point are less than those from non-point.

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

#Aggregating the emissions in Baltimore by year and type
Baltimore_Emissions <- aggregate(Emissions ~ year + type, Baltimore_NEI, sum)

# Opening a png device
png("plot3.png", width=480, height=480, units="px")

# Creating the graph
library(ggplot2)
ggplot <- ggplot(Baltimore_Emissions, aes(factor(year), Emissions, fill=year)) + geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE) + facet_grid(.~type) + labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (in tons)")) + labs(title=expression("Yearly PM"[2.5]*" Emissions In Baltimore By Source Type"))
print(ggplot)

# Closing the png device
dev.off()