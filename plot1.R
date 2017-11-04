setwd("D:/Coursera/DS/Course4_Expl/Week4_assignment/exdata_data_NEI_data/")

# Read data

NEI <- readRDS("summarySCC_PM25.rds")

# make a data frame with total emissions per year

epy <- as.data.frame(matrix(nrow = 4, ncol = 2))
colnames(epy) <- c("Emissions", "year")

epy$year <- unique(NEI$year)
epy$Emissions <- unname(tapply(NEI$Emissions, NEI$year, sum))

# Make barplot

png(filename = "plot1.png", width = 480, height = 480, bg = "white")

barplot(epy$Emissions, epy$year, names.arg = epy$year, ylab = "Emissions", xlab = "year",
        main = "Emissions per year")

dev.off()
