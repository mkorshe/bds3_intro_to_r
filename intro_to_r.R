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


##### Робота з даними ####

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

