## Download and unzip the data file
setwd('C:/Users/xxxxx/Desktop/Course 4_EDA_Proj 2')
if(!file.exists('data')) dir.create('data')
fileUrl <-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile = './data/exdata_NEIdata.zip')
unzip('./data/exdata_NEIdata.zip', exdir = './data')

## read data into R
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

## coal consumption data
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

## Merge two data sets
merge <- merge(x=NEI, y=SCC.coal, by='SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

## Plot 4
require(ggplot2)
if(!file.exists('figures')) dir.create('figures')
png(filename='./figures/plot4.png')
ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) + geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + ggtitle(expression('Total Emissions of PM'[2.5])) + ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + theme(legend.position='none') + scale_colour_gradient(low='black', high='red')
dev.off()
