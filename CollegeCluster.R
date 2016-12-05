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

set.seed(7957)

splitSample <- sample(1:3, size=nrow(NE),replace=TRUE,prob=c(0.2,0.2,0.6))

train <- NE[splitSample==1,]
test <- NE[splitSample==2,]

train2 <- select(train, LOCALE, UGDS, ADM_RATE, C150_4, SAT_AVG, UGDS_BLACK,UGDS_WHITE, UGDS_HISP, UGDS_ASIAN,UGDS_AIAN, UGDS_AIAN, RELAFFIL, COSTT4_A, PCTPELL,PCTFLOAN,INSTNM)

test2 <- select(test, LOCALE, UGDS, ADM_RATE, C150_4, SAT_AVG, UGDS_BLACK,UGDS_WHITE, UGDS_HISP, UGDS_ASIAN,UGDS_AIAN, UGDS_AIAN, RELAFFIL, COSTT4_A, PCTPELL,PCTFLOAN, INSTNM)

# Hierarchical clustering with Dendogram
N <- train2

#calculate Euclidean distance
N.dist <- dist(N)

N.hclust <- hclust(N.dist)

plot(N.hclust,labels=N$INSTNM,main='Dendogram of US Colleges', hang=-1)

#Create a vector showing the cluster5 groups

groups.5<- cutree(N.hclust,5)  # repeat for 4 groups
table (groups.5)
rect.hclust(N.hclust, k=5, border="blue") 

write.table(rect.hclust, col.names=N$INSTNM, sep=groups.5)
N <-cbind(N, groups.5)
write.csv(N,"NEAcad.csv")

