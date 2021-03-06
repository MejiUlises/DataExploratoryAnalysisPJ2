#We load the library so we can reshape the Data
library(reshape2) 

#We load the filos into R
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

#We cast the year and SCC to factors
NEI$year <- as.factor(NEI$year)
NEI$SCC <- as.factor(NEI$SCC)

#We melt the data by year and SCC
meltData <- melt(NEI, id.vars=c("year","SCC"), measure.vars=c("Emissions"))

#We reshape the data by year adding all the values for each year.
TidySet <- dcast(meltData, year ~ variable, sum)

#We make the plot and save it to a file
#Every Value is divided by 1K so the Y label doesnt display exp format numbers.
#This could be done another way, but I don't know how
png(file="plot1.png", width=960, height=960)
with(TidySet, barplot(Emissions/1000, main=expression('Total Emission of PM'[2.5]*' by Year'),xlab="Year", ylab=expression("Total amount of PM"[2.5]*" Produced (1K)"), names.arg=TidySet$year, col="steelblue"))
dev.off()