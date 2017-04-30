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
MD <- subset(NEI, fips=='24510')

## Plot 2
if(!file.exists('figures')) dir.create('figures')
png(filename='./figures/plot2.png')
barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum),main='Total Emission in Baltimore City, MD',xlab='Year', ylab=expression('PM'[2.5]))
dev.off()
