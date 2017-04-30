## Download and unzip the data file
setwd('C:/Users/xxxxx/Desktop/Course 4_EDA_Proj 2')
if(!file.exists('data')) dir.create('data')
fileUrl <-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile = './data/exdata_NEIdata.zip')
unzip('./data/exdata_NEIdata.zip', exdir = './data')

## read data into R
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

## subset Baltimore City, Maryland (fips == "24510") data
NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]
MD <- subset(NEI, fips == 24510)
MD$year <- factor(MD$year, levels=c('1999', '2002', '2005', '2008'))

## Plot 3
require(ggplot2)
if(!file.exists('figures')) dir.create('figures')
png(filename='./figures/plot3.png', width=800, height=400, units='px')
ggplot(data=MD, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) + geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') + ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha=0.10)
dev.off()
