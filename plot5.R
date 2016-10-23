# Exploratory Data Analysis 
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


# Load ggplot2 library
library(ggplot2)

# upload data files
NEI <- readRDS("~/summarySCC_PM25.rds")
View(NEI)

SCC <- readRDS("~/Source_Classification_Code.rds")
View(SCC)

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))


MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')


MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')


png('~/Course Project 2/plot5.png')

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()