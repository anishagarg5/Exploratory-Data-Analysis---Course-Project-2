# Q.6 Compare emissions from motor vehicle sources in Baltimore City with emissions 
#     from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#     Which city has seen greater changes over time in motor vehicle emissions?
# Ans. From the barplot, we can see that the emissions

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

# Sub-setting the data for Baltimore and Los Angeles from NEI
Baltimore_NEI <- NEI[NEI$fips=="24510",]
LA_NEI <- NEI[NEI$fips=="06037",]

# Sub-setting vehicles data from SCC
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC

# Sub-setting vehicles data from Balitmore_NEI and LA_NEI
Baltimore_vehicles_NEI <- Baltimore_NEI[Baltimore_NEI$SCC %in% vehicles_SCC,]
LA_vehicles_NEI <- LA_NEI[LA_NEI$SCC %in% vehicles_SCC,]

# Adding a city column to both the above data sets
Baltimore_vehicles_NEI$city <- "Baltimore City"
LA_vehicles_NEI$city <- "Los Angeles County"

# Combining the above two subsets 
LAB_NEI <- rbind(Baltimore_vehicles_NEI, LA_vehicles_NEI)

# Opening a png device
png("plot6.png", width=480, height=480, units="px")

# Creating the graph
library(ggplot2)
ggplot <- ggplot(LAB_NEI, aes(factor(year), Emissions, fill=year)) + geom_bar(stat="identity") + facet_grid(scales="free", space="free", .~city)
            theme_bw() +  guides(fill=FALSE) + labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (in 10^5 tons)")) + 
            labs(title=expression("Yearly PM"[2.5]*" Emissions From Motor Vehicle Sources In Baltimore and LA"))

print(ggplot)

# Closing the png device
dev.off()