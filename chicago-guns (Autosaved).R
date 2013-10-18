 #defining some useful functions
get_second_element <- function(item) {
  return (item[2])
}

get_first_element <- function(item) { return(item[1])}
 
# load the data
data <- read.delim("http://shancarter.github.io/ucb-dataviz-fall-2013/classes/data-practice/county-data.txt", header=F, stringsAsFactors=F)
 
# rename it like a human
names(data) <- c("county_orig", "guns_orig")
 
# split it up based on parenthesis
split <- strsplit(data$county_orig, split="\\(")
  
data$state_clean <- sapply(split, get_second_element)

gsub("\\)","", data$state_clean)
data$state_clean <- gsub("\\)","", data$state_clean)
data$county_clean <- sapply(split, get_first_element)

#Making sure there are no commas and turning this into numric
data$guns_clean <- as.numeric(gsub("\\,", "", data$guns_orig))

#Getting data
states <- readShapePoly("shape_files/good_shapes/nytlayout_state.shp")

#First we want to aggregate before merging
guns_by_state <- aggregate(data$guns_clean, list(data$STATE_ABBR), sum)

#Renaming
names(guns_by_state) <- c("STATE_ABBR", "guns")

#Sorting
guns_by_state <- guns_by_state[order(guns_by_state$guns, decreasing = TRUE),]

mapping_out <- merge(map_data,guns_by_state, by = "STATE_ABBR")
# checking the class
class(mapping_out)
# checking the class again
class(states)
# matching
match(mapping_out$STATE_ABBR, map_data$STATE_ABBR)
# Naming the file
 match_order <- match(mapping_out$STATE_ABBR, map_data$STATE_ABBR)
mapping_out[match_order]

#matching again
map_data$guns <- mapping_out4guns[match_order]

map_breaks <- c(0,250,500,750,1000,3000, 8000, 30000)
buckets <- cut(map_data$guns, breaks = map_breaks)
numeric_buckets <- as.numeric(buckets)
library(RColorBrewer)
display.brewer.all()
colors <- brewer.pal(7,"Reds")
colors[numeric_buckets]
plot(states, col = colors[numeric_buckets])


