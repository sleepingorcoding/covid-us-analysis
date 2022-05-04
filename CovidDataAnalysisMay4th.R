
# Data source https://www.kaggle.com/datasets/tunguz/data-on-covid19-coronavirus

#Loading libraries
# install.packages("tidyverse")
# install.packages("funModeling")
# install.packages("Hmisc")
library(data.table)
library(funModeling)
library(Hmisc)
library(ggplot2)

###################
# Read data
###################
dt <- fread("owid-covid-data.csv")

###################
# View data
###################
View(dt)


###########################################################################
# Step 1. Check for missing values, zeroes, data type, & any unique values.
###########################################################################

# Total rows, columns, and column names.
nrow(dt)
ncol(dt)

# Basic profiling
df_status(dt)

# Profiling categorical variables
freq(dt)

# Profiling numerical variables
plot_num(dt)

###############################
# 2. Data of interest.
###############################

# North America Only
nA <- dt[location == 'North America']

# Select some columns
nA <- nA[, .(iso_code, location, date, total_vaccinations, people_fully_vaccinated_per_hundred, people_vaccinated_per_hundred)]
nA <- nA[!is.na(total_vaccinations)]
# nA <- nA[complete.cases(nA)]

##############################################
# 3. Visualization
##############################################
p1 <- ggplot(data = nA, aes(x = date, y = people_vaccinated_per_hundred, color = location))
p1 + geom_line(size=1.2) + scale_y_continuous(breaks=c(0,20,40,60), labels= scales::comma) + 
  labs(titles = '% of vaccinated people in the United States',
       x = 'Date',
       y = '% vaccinated people')
    
