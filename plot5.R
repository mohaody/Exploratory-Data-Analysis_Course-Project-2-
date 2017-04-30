## Download and unzip the data file
setwd('C:/Users/xxxxx/Desktop/Course 4_EDA_Proj 2')
if(!file.exists('data')) dir.create('data')
fileUrl <-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile = './data/exdata_NEIdata.zip')
unzip('./data/exdata_NEIdata.zip', exdir = './data')

## read data into R
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

## subset Baltimore City, Maryland and aggregate data
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

## Plot 5
require(ggplot2)
if(!file.exists('figures')) dir.create('figures')
png(filename='./figures/plot5.png')
ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(stat='identity') + guides(fill=F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))
dev.off()
