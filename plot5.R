setwd("D:/Coursera/DS/Course4_Expl/Week4_assignment/exdata_data_NEI_data/")

# Read data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Identify vehicle related sources

veh <- as.character(SCC$SCC[grep("Vehicle", SCC$EI.Sector)])
NEIveh <- NEI[NEI$SCC %in% veh, ]

# Calculate total emissions per year in Baltimore City

NEIB <- NEIveh[NEIveh$fips == "24510", ]

Balt <- setNames(aggregate(NEIB$Emissions, by=list(year=NEIB$year, type=NEIB$type), FUN=sum), 
                 nm = c("year", "type", "Emissions"))

# Make plot

library(ggplot2)

png(filename = "plot5.png", width = 480, height = 480, bg = "white")

myplot <- qplot(x = year, y = Emissions, data = Balt, xlab = "year", ylab = "Emissions", 
                main = "Vehicle Emissions in Baltimore City") + geom_line()

print(myplot)

dev.off()