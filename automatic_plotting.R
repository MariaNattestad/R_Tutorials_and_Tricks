# This script is an automatic system for reading in a data set and creating 3 different plots from it. 
# The plots are automatically saved as the input filename plus an extension describing the plot

library(ggplot2)

# Select a data file
filename <- "example_variants.bed"

# Read the data into a data.frame
my_data <- read.csv(filename, sep="\t", quote='', stringsAsFactors=FALSE,header=FALSE)

# Rename the columns so we can plot things more easily without looking up which column is which
names(my_data) <- c("chrom","start","stop","type","size","strand","all.sizes","ref.dist","query.dist","contig.name")

my_data <- my_data[my_data$type %in% c("Insertion","Deletion","Contraction","Expansion"),]

# Put the types and the chromosomes in the order we want them to be plotted
my_data$type <- factor(my_data$type, levels = c("Insertion","Deletion","Expansion","Contraction"))
my_data$chrom <- factor(my_data$chrom, levels = c(seq(22),"X","Y"))

# Set the theme with a bigger font size
theme_set(theme_gray(base_size = 24))

# Report some basic statistics that you might want to put in a table in your paper:
summary(my_data$type)


################################################
# start new plot as a .png file
plot.output.filename <- paste(filename,".event_size_by_event_type_500bp.png",sep="")
png(file=plot.output.filename,width=800,height=800)

# plot 1
r <- ggplot(my_data,aes(x=size,fill=type))
r+geom_bar(binwidth=4)+labs(x = "Variant size",y="Count",fill="Variant type") + xlim(50,500) 

# end this plot
dev.off()
################################################

################################################
# start new plot as a .png file
plot.output.filename <- paste(filename,".ref_vs_query_distances_500bp.png",sep="")
png(file=plot.output.filename,width=800,height=800)

# plot 2
r <- ggplot(my_data,aes(x=ref.dist,y=query.dist,color=type))
r+geom_point()+xlim(-500,500)+ylim(-500,500)+labs(x="Reference distance", y="Query distance",color="Variant type")

# end this plot
dev.off()
################################################

################################################
# start new plot as a .png file

plot.output.filename <- paste(filename,".event_types_by_chromosome.png",sep="")
png(file=plot.output.filename,width=800,height=800)

# plot 3
my_data$chrom <- factor(my_data$chrom, levels = c(seq(22),"X","Y"))
r <- ggplot(my_data,aes(x=chrom,fill=type))
r+geom_bar()+labs(x = "Chromosome",y="Count",fill="Variant type")

# end this plot
dev.off()
################################################


