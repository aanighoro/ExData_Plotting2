setwd("D:/Coursera/DS/Course4_Expl/Week4_assignment/exdata_data_NEI_data/")

# Read data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Identify vehicle related sources

veh <- as.character(SCC$SCC[grep("Vehicle", SCC$EI.Sector)])
NEIveh <- NEI[NEI$SCC %in% veh, ]

# Calculate total emissions per year in Baltimore City

NEIB <- NEIveh[NEIveh$fips == "24510", ]
NEILA <- NEIveh[NEIveh$fips == "06037", ]
NEIBLA <- rbind(NEIB, NEILA)

BaltLA <- setNames(aggregate(NEIBLA$Emissions, by=list(year=NEIBLA$year, County=NEIBLA$fips), FUN=sum), 
                 nm = c("year", "County", "Emissions"))
BaltLA$County <- gsub("24510", "Baltimore City", BaltLA$County)
BaltLA$County <- gsub("06037", "Los Angeles", BaltLA$County)

# Make plot

library(ggplot2)

png(filename = "plot6.png", width = 480, height = 480, bg = "white")

myplot <- qplot(x = year, y = Emissions, data = BaltLA, xlab = "year", ylab = "Emissions", 
                color = County, main = "Vehicle Emissions in Baltimore City and Los Angeles") + geom_line()

print(myplot)

dev.off()