setwd("D:/Coursera/DS/Course4_Expl/Week4_assignment/exdata_data_NEI_data/")

# Read data

NEI <- readRDS("summarySCC_PM25.rds")

# make a data frame with total emissions per year in Baltimore City

NEIB <- NEI[NEI$fips == "24510", ]
Balt <- setNames(aggregate(NEIB$Emissions, by=list(year=NEIB$year, type=NEIB$type), FUN=sum), 
                 nm = c("year", "type", "Emissions"))

# Make plot

library(ggplot2)

png(filename = "plot3.png", width = 480, height = 480, bg = "white")

myplot <- qplot(x = year, y = Emissions, data = Balt, xlab = "year", ylab = "Emissions", color = type, 
                main = "Emissions in Baltimore City") + geom_line()

print(myplot)

dev.off()