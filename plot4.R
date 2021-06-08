# Q.4 Across the United States, how have emissions from coal combustion-related 
#     sources changed from 1999–2008?
# Ans. From the barplot, we can see that the emissions have decreased.

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

unique(SCC$SCC.Level.One)
unique(SCC$EI.Sector)

# Sub-setting the coal combustion data from SCC data set
comb <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 

# Creating a logical vector for coal combustion
coal_comb <- (comb & coal)

coal_comb_SCC <- SCC[coal_comb,]$SCC

# Sub-setting the coal combustion data from NEI data set
coal_comb_NEI <- NEI[NEI$SCC %in% coal_comb_SCC,]

# Opening a png device
png("plot4.png",width=480,height=480,units="px")

# Creating the graph
library(ggplot2)
ggplot <- ggplot(coal_comb_NEI, aes(factor(year), Emissions/10^5)) + geom_bar(stat="identity", fill="#9999CC") +
            theme_bw() +  guides(fill=FALSE) + labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (in 10^5 tons)")) + labs(title=expression("Yearly PM"[2.5]*" Emissions From Coal-Combustion Related Sources Across US"))
print(ggplot)

# Closing the png device
dev.off()