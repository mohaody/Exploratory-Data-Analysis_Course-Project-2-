## Download and unzip the data file
setwd('C:/Users/mohao/Desktop/Course 4_EDA_Proj 2')
if(!file.exists('data')) dir.create('data')
fileUrl <-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile = './data/exdata_NEIdata.zip')
unzip('./data/exdata_NEIdata.zip', exdir = './data')

## read data into R
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

## sampling and aggregating the data
NEI_sampling <- NEI[sample(nrow(NEI), size=2000, replace=F),]
Emissions <- aggregate(NEI[,'Emissions'], by=list(NEI$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

## Plot 1
if(!file.exists('figures')) dir.create('figures')
png(filename='./figures/Plot1.png')
barplot(Emissions$PM, names.arg=Emissions$Group.1, main=expression('Total Emission of PM'[2.5]), xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()
