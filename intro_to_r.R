#День 1
3 + 5
12/7

#####

# assign 3 to a
a <- 3
# assign 5 to b
b <- 5

# what now is a
a
# what now is b
b

#Add a and b
a + b

# Що станеться, якщо ми змінимо a, а потім знову додамо a і b?
#   Чи працює це, якщо ви просто змінюєте a в сценарії, а потім додаєте a і b? Ви все ще отримували ту саму відповідь після того, як вони змінили a? Якщо так, то чому, на вашу думку, це може бути?
#   Ми також можемо призначити a + b новій змінній c. Як би ви це зробили?

#####
# Assigns a value to a variable
genome_size_mb <- 35

# Assigns a value to a variable and prints it out on the console
(genome_size_mb <- 35)

# Prints out the value of a variable on the console
genome_size_mb

#####

round(3.14159)

round(3.14159, 2)

#Ми будемо працювати з довжиною генома. - Створіть змінну genome_length_mb і присвойте їй значення 4.6

#genome_length_mb / 978.0


#####

glengths <- c(4.6, 3000, 50000)
glengths

#Вектор також може містити символи:

species <- c("ecoli", "human", "corn")
species
#
5 * glengths
str(glengths)
str(species)

class(glengths)
class(species)

lengths <- c(glengths, 90) # adding at the end
lengths <- c(30, glengths) # adding at the beginning
lengths

#

?barplot

??geom_point

install.packages(c("BiocManager", "remotes"))
BiocManager::install(c("tidyverse", "SummarizedExperiment",
                       "UCLouvain-CBIO/rWSBIM1207", "hexbin",
                       "patchwork", "gridExtra", "lubridate"))

##### Робота з даними - завантаження і читання ####

download.file("https://raw.githubusercontent.com/datacarpentry/R-genomics/gh-pages/data/Ecoli_metadata.csv", "Ecoli_metadata.csv")

metadata <- read.csv('Ecoli_metadata.csv')
head(metadata)
str(metadata)

# Size:
#   dim() - returns a vector with the number of rows in the first element, and the number of columns as the second element (the __dim__ensions of the object)
# nrow() - returns the number of rows
# ncol() - returns the number of columns
# Content:
#   head() - shows the first 6 rows
# tail() - shows the last 6 rows
# Names:
#   names() - returns the column names (synonym of colnames() for data.frame objects)
# rownames() - returns the row names
# Summary:
#   str() - structure of the object and information about the class, length and content of each column
# summary() - summary statistics for each column

# Що таке клас метаданих об’єкта?
# Скільки рядків і скільки стовпців у цьому об’єкті?
# Скільки цитрат+ мутантів було зареєстровано в цій популяції? citrate+ mutants


##### Робота з даними - data frame  ####

ten_letters <- c('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j')
ten_letters[2]
ten_letters[c(1,7)]

ten_letters[3:6]

ten_letters[10:1]

ten_letters[c(2, 8:10)]

#

seq(1, 10, by = 2)
seq(20, 4, by = -3)

#

metadata[1, 2]   # 1st element in the 2nd column 
metadata[1, 6]   # 1st element in the 6th column
metadata[1:3, 7] # First three elements in the 7th column
metadata[3, ]    # 3rd element for all columns
metadata[, 7]    # Entire 7th column

# The function nrow() on a data.frame returns the number of rows. For example, try typing nrow(metadata). Usenrow()andseq()to create a new data frame calledmeta_by_2that includes all even numbered rows ofmetadata`.
# Select the strain column from metadata
metadata[ , "strain"]

# Alternatively...
metadata$strain

metadata[, c("strain", "clade")]

metadata[4:7, c("strain", "clade")]

##### dplyr ####

install.packages("dplyr") ## install
library("dplyr")          ## load
select(metadata, sample, clade, cit, genome_size)
filter(metadata, cit == "plus")


metadata %>%
  filter(cit == "plus") %>%
  select(sample, generation, clade)

meta_citplus <- metadata %>%
  filter(cit == "plus") %>%
  select(sample, generation, clade)

meta_citplus

# Challenge
# Using pipes, subset the data to include rows where the clade is ‘Cit+’. Retain columns sample, cit, and genome_size.


metadata %>%
  mutate(test = genome_size/generation)

new_table <-
metadata %>%
  mutate(genome_bp = genome_size *1e6)

metadata %>%
  mutate(genome_bp = genome_size *1e6) %>%
  filter(!is.na(clade)) %>%
  nrow() %>% 
  ggplot() 
  #head

#створити колонку genome_round - округлити genome_size до першого знаку після коми
#відфільтрувати cit plus
#побудувати гістограму з genome_round на осі x

#
  
#

my_df <- matrix(nrow = 3,ncol = 3, data = c(1:9))
my_df
my_df <- as.data.frame(my_df)

colnames(my_df) <- c('Name','Age', 'City')

print(colnames(my_df))

my_df$new_column <- c(1:3)
my_df[,'another_column'] <- 'G'

my_df$new_column <- NULL
my_df$another_column <- NULL

my_df_2 <- my_df[,c('Age')]

my_df_3 <- my_df[my_df$Name> 2, c('City')]
my_df_3 <- my_df[my_df$Name> 2, c('City', "another_column")]

#
my_df[order(my_df$Name),]



my_df$KKK <- c(1:3)

my_df_s <- my_df[my_df$KKK >1,]




metadata %>%
  group_by(cit) %>%
  summarize(n())

#

metadata %>%
  group_by(cit) %>%
  summarize(mean_size = mean(genome_size, na.rm = TRUE))

metadata %>%
  group_by(cit, clade) %>%
  summarize(mean_size = mean(genome_size, na.rm = TRUE))

metadata %>%
  group_by(cit, clade) %>%
  summarize(mean_size = mean(genome_size, na.rm = TRUE)) %>%
  filter(!is.na(clade))


metadata %>%
  group_by(cit, clade) %>%
  summarize(mean_size = mean(genome_size, na.rm = TRUE),
            min_generation = min(generation))

##### data visualization ####
library(tidyverse)
genome_size <- metadata$genome_size

plot(genome_size)

plot(genome_size, pch=3)

plot(genome_size, pch=4, main="Scatter plot of genome sizes")

hist(metadata$generation, breaks = 3)

boxplot(genome_size ~ clade, metadata)

boxplot(genome_size ~ cit, metadata, col=c("pink","purple", "darkgrey"),
        main="Average expression differences between celltypes", ylab="Expression",
        xlab="Bacteria type")

#### Advanced visualization ####

library(ggplot2)

ggplot(metadata) +
  geom_point() 

ggplot(metadata) +
  geom_point(aes(x = clade, y= genome_size, color = cit)) +
  labs(x = "Clade", 
       y = "Genome size of bacteria",
       color = "Bacteria type") +
  theme(axis.text.x = element_text(angle=45, hjust=1)) 

ggplot(metadata) +
  geom_point(aes(x = sample, y= genome_size, color = generation, shape = cit), size = rel(3.0)) +
  guides(color = guide_legend(title = "Users By guides"))#+
  #theme(axis.text.x = element_text(angle=45, hjust=1)) 

ggplot(metadata) +
  geom_bar(aes(x = genome_size))


ggplot(metadata) +
  geom_bar(aes(x = genome_size), stat = "bin", binwidth=0.005)


ggplot(metadata) +
  geom_boxplot(aes(x = cit, y = genome_size, fill = cit)) +
  ggtitle('Boxplot of genome size by citrate mutant type') +
  xlab('citrate mutant') +
  ylab('genome size') +
  theme(panel.grid.major = element_line(size = .5, color = "white"),
        axis.text.x = element_text(angle=45, hjust=1),
        axis.title = element_text(size = rel(1.5)),
        axis.text = element_text(size = rel(1.25)))

#pdf("boxplot.pdf")

ggplot(example_data) +
  geom_boxplot(aes(x = cit, y =....) +
                 ggtitle(...) +
                 xlab(...) +
                 ylab(...) +
                 theme(panel.grid.major = element_line(...),
                       axis.text.x = element_text(...),
                       axis.title = element_text(...),
                       axis.text = element_text(...))