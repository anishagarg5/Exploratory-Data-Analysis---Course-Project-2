# Q.5 How have emissions from motor vehicle sources changed from 1999–2008 in 
#     Baltimore City?
# Ans. From the barplot, we can see that the emissions have decreased from 1999 
#      to 2008.

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

# Sub-setting vehicles data from SCC
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC

# Sub-setting vehicles data from Balitmore_NEI
Baltimore_vehicles_NEI <- Baltimore_NEI[Baltimore_NEI$SCC %in% vehicles_SCC,]

# Opening a png device
png("plot5.png", width=480, height=480, units="px")

# Creating the graph
library(ggplot2)
ggplot <- ggplot(Baltimore_vehicles_NEI, aes(factor(year), Emissions)) + geom_bar(stat="identity", fill="#CC6666") +
            theme_bw() +  guides(fill=FALSE) + labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (in 10^5 tons)")) + 
            labs(title=expression("Yearly PM"[2.5]*" Emissions From Motor Vehicle Sources In Baltimore City"))

print(ggplot)

# Closing the png device
dev.off()