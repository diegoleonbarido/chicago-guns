 
get_second_element <- function(item) {
  return (item[2])
}
 
# load the data
data <- read.delim("http://shancarter.github.io/ucb-dataviz-fall-2013/classes/data-practice/county-data.txt", header=F, stringsAsFactors=F)
 
# rename it like a human
names(data) <- c("county_orig", "guns_orig")
 
 
# split it up based on parenthesis
split <- strsplit(data$county_orig, split="\\(")
 
 
data$state_clean <- sapply(split, get_second_element)
