#####################################
#  unsuper_acc.R                    #
# In-class demo of Clustering       #
#  using Utilities data             #
#  hierarchical and kmeans          #
#####################################

## Read and examine data
mydata <- read.csv("NEAcad.csv")

str(mydata)
attach(mydata)   # Attach command simplifies variable references

## A little exploration with base scatterplot
# Here we make one scatterplot; in a real study you'd explore more

plot(SAT_AVG ~ ADM_RATE, data = mydata)
# now label points 
with(mydata,text(SAT_AVG ~ ADM_RATE, labels=INSTNM,pos=3))

##  Data preparation
mydata.use <- mydata[,c(1:11,13:15)]  # data frame without columns 11, 15

means <- apply(mydata.use,2,mean)  
sds <- apply(mydata.use,2,sd)
# scale function rescales (normalizes original data)
mydata.use <- scale(mydata.use,center=means,scale=sds)

#calculate distance matrix (default is Euclidean distance)
mydata.dist <- dist(mydata.use)
mydata.dist   # display the distances

#  k-means analysis

n <- nrow(mydata.use)-1
wss <- (n)*sum(apply(mydata.use,2,var))
for (i in 2:n) wss[i] <- sum(kmeans(mydata.use,
centers=i)$withinss)
plot(1:n, wss, type="b", xlab="Number of Clusters",
ylab="Within groups sum of squares",
main="Within groups SS vs. k Cluster") 


# Now compute and graph k=means clusters
options(digits=2)  # round numbers to 2 decimals
kc <- kmeans(mydata.use,5)   # initially us k=5 cluster solution
kc

# Now graph it
mydatak <-as.data.frame(mydata.use)  # convert to dataframe
mydatak <-cbind(mydatak, mydata$INSTNM) # bind the column of names
mydatak <-cbind(mydatak, kc$cluster) # bind the column of names

plot(COSTT4_A ~ ADM_RATE, data = mydata, col=kc$cluster)
# now label points 
with(mydata,text(COSTT4_A ~ ADM_RATE, labels=INSTNM,pos=4))


