setwd("D:/Coursera/DS/Course4_Expl/Week4_assignment/exdata_data_NEI_data/")

# Read data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Identify coal related sources

coal <- as.character(SCC$SCC[grep("Comb.+Coal", SCC$EI.Sector)])
NEIcoal <- NEI[NEI$SCC %in% coal, ]

# Calculate total emissions per year

NEIcoal <- setNames(aggregate(NEIcoal$Emissions, by = list(NEIcoal$year), FUN = sum),
                    nm = c("year", "Emissions"))

# Make plot

library(ggplot2)

png(filename = "plot4.png", width = 480, height = 480, bg = "white")

myplot <- qplot(x = year, y = Emissions, data = NEIcoal, xlab = "year", ylab = "Emissions", 
                main = "Coal Combustion Related Emissions") + geom_line()

print(myplot)

dev.off()