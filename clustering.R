library(gplots)
# Select a data file
filename <- "example_heatmap.txt"

# Read the data into a data.frame
my_data <- read.table(filename, sep="\t", quote="", stringsAsFactors=FALSE,header=TRUE)

head(my_data)

nrow(my_data)
ncol(my_data)

data_columns_only <- my_data[,c(4:(ncol(my_data)-1))]

head(data_columns_only)
my_matrix <- as.matrix(data_columns_only)
head(my_matrix)


# Heatmap without any clustering, so the rows and columns are in the same order as in our data:
heatmap.2(my_matrix,dendrogram="none",Colv=FALSE,Rowv=FALSE,xlab="Bins",ylab="Samples",trace="none")

# We can use the t() "transform" to flip the data around if necessary:
transformed_matrix <- t(my_matrix)
heatmap.2(transformed_matrix,dendrogram="none",Colv=FALSE,Rowv=FALSE,xlab="Bins",ylab="Samples",trace="none")

# We can add a dendrogram to just one side (in this case to cluster the samples but not the bins in the genome):
heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none")

# We can also make a dendrogram to cluster the genome bins but not the samples
heatmap.2(transformed_matrix,dendrogram="row",Colv=FALSE,Rowv=TRUE,xlab="Samples",ylab="Bins",trace="none")

# Or we can cluster them both
heatmap.2(transformed_matrix,dendrogram="both",Colv=TRUE,Rowv=TRUE,xlab="Samples",ylab="Bins",trace="none")

# And you can cluster without the dendrogram 
heatmap.2(transformed_matrix,dendrogram="none",Colv=TRUE,Rowv=TRUE,xlab="Samples",ylab="Bins",trace="none")

# you just can't draw the dendrogram without clustering:
heatmap.2(transformed_matrix,dendrogram="row",Colv=FALSE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none")


# We can change lots of little things by going to the documentation and trying different settings:
?heatmap.2

# baseline:
heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none")


heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none",key=FALSE)
heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none",key.title="")
heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none",density.info="density")
heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none",density.info="none")
heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none",labRow="")




# And just like our automatic script, we can save plots the same way regardless of how we made them

library(gplots)
# Select a data file
filename <- "/Users/mnattest/Dropbox/R_for_Biologists/code/workshop_1/test_Ginkgo.txt"

# Read the data into a data.frame
my_data <- read.table(filename, sep="\t", quote="", stringsAsFactors=FALSE,header=TRUE)

# Clean data and change to a matrix so we can make a heatmap out of it
data_columns_only <- my_data[,c(4:(ncol(my_data)-1))]
my_matrix <- as.matrix(data_columns_only)

# start plotting in file:
plot.filename <- paste(filename,".heatCor.jpeg",sep="")
jpeg(plot.filename, width=800, height=800)

# make the plot itself:
heatmap.2(transformed_matrix,dendrogram="column",Colv=TRUE,Rowv=FALSE,xlab="Samples",ylab="Bins",trace="none")

# end this plot:
dev.off()




