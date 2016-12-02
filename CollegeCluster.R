setwd("~/MyData")
library(class)
library(dplyr)
library(ggplot2)

NE<- read.csv("NE.csv")

NE$HIGHDEG <-as.factor(NE$HIGHDEG)
NE$UGDS <- as.numeric(NE$UGDS)
NE$ADM_RATE <- as.numeric(NE$ADM_RATE)
NE$C150_4 <- as.numeric(NE$C150_4)
NE$SAT_AVG <- as.numeric(NE$SAT_AVG)
NE$UGDS_BLACK <- as.numeric(NE$UGDS_BLACK)
NE$UGDS_WHITE <- as.numeric(NE$UGDS_WHITE)
NE$UGDS_HISP <-as.numeric(NE$UGDS_HISP)
NE$UGDS_ASIAN <- as.numeric(NE$UGDS_ASIAN)
NE$UGDS_AIAN <-as.numeric(NE$UGDS_AIAN)
NE$UGDS_NRA <-as.numeric(NE$UGDS_NRA)
NE$COSTT4_A <- as.numeric(NE$COSTT4_A)
NE$PCTPELL <- as.numeric(NE$PCTPELL)
NE$PCTFLOAN <- as.numeric(NE$PCTFLOAN)

set.seed(2342)

splitSample <- sample(1:2, size=nrow(NE),replace=TRUE,prob=c(0.7,0.3))

train <- NE[splitSample==1,]
test <- NE[splitSample==2,]

train2 <- select(train, LOCALE, UGDS, ADM_RATE, C150_4, SAT_AVG, UGDS_BLACK,UGDS_WHITE, UGDS_HISP, UGDS_ASIAN,UGDS_AIAN, UGDS_AIAN, RELAFFIL, COSTT4_A, PCTPELL,PCTFLOAN)

test2 <- select(test, LOCALE, UGDS, ADM_RATE, C150_4, SAT_AVG, UGDS_BLACK,UGDS_WHITE, UGDS_HISP, UGDS_ASIAN,UGDS_AIAN, UGDS_AIAN, RELAFFIL, COSTT4_A, PCTPELL,PCTFLOAN)

# Hierarchical clustering with Dendogram

#calculate Euclidean distance
NE.dist <- dist(NE)

NE.hclust <- hclust(NE.dist)

plot(NE.hclust,labels=NE$INSTNM,main='Dendogram of US Colleges', hang=-1)

#Create a vector showing the cluster5 groups

groups.5<- cutree(NE.hclust,5)  # repeat for 4 groups
table (groups.5)
rect.hclust(NE.hclust, k=5, border="blue") 

write.table(rect.hclust, row.names=NE$INSTNM, sep=groups.5)

