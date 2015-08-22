library(ggplot2)

# Select a data file
filename <- "example_variants.bed"

# Read the data into a data.frame
my_data <- read.csv(filename, sep="\t", quote='', stringsAsFactors=TRUE,header=FALSE)

head(my_data)

names(my_data)

names(my_data) <- c("chrom","start","stop","type","size","strand","all.sizes","ref.dist","query.dist","contig.name")

head(my_data)


# Basic statistics:

mean(my_data$size)
sd(my_data$size)
median(my_data$size)
max(my_data$size)
min(my_data$size)

summary(my_data$type)
summary(my_data$chrom)


# example of a basic t-test
set1 <- my_data[my_data$type=="Insertion","size"]

set2 <- my_data[my_data$type=="Deletion","size"]

t.test(set1,set2)

##########################################################
########## Before we get started with plotting, check 
########## out your manual for plotting with ggplot2:
########## http://docs.ggplot2.org/current/
##########################################################


##########################################################
### Plot 1
### A size histogram with each type as a different color
########################################################## 

ggplot(my_data,aes(x=size,fill=type)) + geom_bar()


r <- ggplot(my_data,aes(x=size,fill=type))
r+geom_bar()

# Too many combinations of types, let's keep it simple by filtering those combinations away

my_data <- my_data[my_data$type %in% c("Insertion","Deletion","Contraction","Expansion"),]

######### side note:
# another example of filtering: 
size.filtered.my_data <- my_data[my_data$size >= 100,]
#########

r <- ggplot(my_data,aes(x=size,fill=type))

r+geom_bar()

# Problem solved, but what if we want the types ordered a certain way?
my_data$type <- factor(my_data$type, levels = c("Insertion","Deletion","Expansion","Contraction"))

# Now we can see the types again like we did above: 
summary(my_data$type)

# And when we plot this again, the legend shows the right order:
r <- ggplot(my_data,aes(x=size,fill=type))

r+geom_bar()

# Awesome, but the text is a bit small:
theme_set(theme_gray(base_size = 24))
# This sets the theme for the rest of the plotting we do, which is convenient for keeping a consistent theme across your figures

# Now try again:
r+geom_bar()

# Other themes are available too:
theme_set(theme_bw(base_size = 24, base_family = "Times New Roman"))
r+geom_bar()

# You can make custom changes to the themes by changing settings explicitly:
theme_set(theme_gray(base_size = 24) + theme(panel.background = element_rect(colour = "pink",size=rel(20)), axis.text = element_text(colour = "blue")))
r+geom_bar()

# Whatever changes you make here will apply to all the plots you make in this R session, allows you to make all your figures have the same theme without setting it for each figure separately
# you can undo it by setting the theme back to the default:
theme_set(theme_gray())

# Set theme back again to the default with large text:
theme_set(theme_gray(base_size = 24))

# zoom in by setting where the x-axis should start and stop:
r <- ggplot(my_data,aes(x=size,fill=type))
r+geom_bar() + xlim(100,500)

# now we might want smaller bins to show more resolution:
r+geom_bar(binwidth=5) + xlim(100,500)

# Let's rewrite the labels for the axes and the legend:
r+geom_bar(binwidth=5) + xlim(100,500) + labs(x = "Variant size",y="Count",fill="Variant type")

# and finally we can always log-scale the y-axis:
r+geom_bar(binwidth=5) + xlim(100,500) +labs(x = "Variant size",y="Count",fill="Variant type") + scale_y_log10()
# log-scale doesn't make sense here, but is often needed in other plots

##########################################################
### And now for something completely different...
### Plot 2
### A scatter plot comparing two variables
##########################################################

r <- ggplot(my_data,aes(x=ref.dist,y=query.dist,color=type))

r+geom_point()

r+geom_point()+xlim(-500,500)+ylim(-500,500)+labs(x="Reference distance", y="Query distance",color="Variant type") 


# we can save the plot with all these options as a variable
basic.plot <- r+geom_point()+xlim(-500,500)+ylim(-500,500)+labs(x="Reference distance", y="Query distance",color="Variant type") 

basic.plot

# we can change the colors too
basic.plot + scale_colour_manual(values = c("red","blue", "green","yellow"))

basic.plot + scale_colour_brewer(type="qual",palette=1)
basic.plot + scale_colour_brewer(type="qual",palette=2)
basic.plot + scale_colour_brewer(type="qual",palette=7)

basic.plot + scale_colour_brewer(type="seq",palette=1)
basic.plot + scale_colour_brewer(type="div",palette=2)
##########################################################

##########################################################
### And now for something completely different...
### Plot 3
### A bar chart (categorical)
##########################################################


r <- ggplot(my_data,aes(x=chrom,fill=type))

r+geom_bar()

# Put the chromosomes in the right order
my_data$chrom <- factor(my_data$chrom, levels = c(seq(22),"X","Y"))

# Now the table we made before will be ordered right too:
summary(my_data$chrom)

# create plot again
r <- ggplot(my_data,aes(x=chrom,fill=type))
r+geom_bar()

# Add labels, etc. 
r+geom_bar()+labs(x = "Chromosome",y="Count",fill="Variant type")





##########################################################

# and just be creative and try different combinations:

ggplot(my_data,aes(x=chrom,y=size,fill=type, color=type)) + geom_point()

ggplot(my_data,aes(x=chrom,y=size,fill=type, color=type)) + geom_point() + facet_grid(. ~ type)

ggplot(my_data,aes(x=chrom,y=size,fill=type, color=type)) + geom_point() + facet_grid(type ~ .)

ggplot(my_data,aes(x=chrom,y=size,fill=type, color=type)) + geom_boxplot() + facet_grid(. ~ type)

ggplot(my_data,aes(x=ref.dist,y=query.dist,fill=type, color=type)) + geom_point() + facet_grid(type ~ chrom)

ggplot(my_data,aes(x=size,fill=type, color=type)) + geom_dotplot() + facet_grid(. ~ type)


##########################################################

# Now we just want to transform this into a system that will produce consistent results and save us some clicking by automatically saving all the plots for us

