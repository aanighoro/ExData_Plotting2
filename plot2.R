setwd("D:/Coursera/DS/Course4_Expl/Week4_assignment/exdata_data_NEI_data/")

# Read data

NEI <- readRDS("summarySCC_PM25.rds")

# make a data frame with total emissions per year in Baltimore City

epy <- as.data.frame(matrix(nrow = 4, ncol = 2))
colnames(epy) <- c("Emissions", "year")

Balt <- NEI[NEI$fips == "24510", ]
epy$year <- unique(Balt$year)
epy$Emissions <- unname(tapply(Balt$Emissions, Balt$year, sum))

# Make barplot

png(filename = "plot2.png", width = 480, height = 480, bg = "white")

barplot(epy$Emissions, epy$year, names.arg = epy$year, ylab = "Emissions", xlab = "year", 
        main = "Emissions in Baltimore City")

dev.off()
