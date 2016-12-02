setwd("~/MyData")
library(class)
library(dplyr)
library(ggplot2)

USColleges <- read.csv("MERGED2014_15_PP.csv")

USColleges <- select(USColleges, HIGHDEG, REGION, INSTNM, CITY, STABBR, LATITUDE, LONGITUDE, LOCALE, UGDS, ADM_RATE, C150_4, SAT_AVG, UGDS_BLACK, UGDS_WHITE, UGDS_HISP, UGDS_ASIAN, UGDS_AIAN, UGDS_AIAN, UGDS_NRA, RELAFFIL, COSTT4_A, PCTPELL, PCTFLOAN, CCBASIC)

FourYear <- c("3", "4")
Acad <- c("15","16","17", "18","19","20","21","22","23")
FourYearColleges <- filter(USColleges, HIGHDEG %in% FourYear)
FourYearColleges <- filter(FourYearColleges, CCBASIC %in% Acad)

NE<-filter(FourYearColleges, REGION==1)

write.csv(NE, "~/MyData/NE.csv")

