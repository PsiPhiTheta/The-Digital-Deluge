# T Hollis (CSC2552, University of Toronto) -v2.1
#     - Purpose: Analyse Microsoft collected data
#     - Bugs & issues: no bugs, no issues, no warnings

######## Approach 1 ########

install.packages("rJava")
library("rJava")
install.packages("xlsx")
library("xlsx") # make sure java is installed, if error run "sudo R CMD javareconf"
install.packages("jsonlite")
library("jsonlite")

json_data2 <- fromJSON("ProductAndServiceUsage.json", flatten=TRUE)
(json_data2)
write.xlsx(json_data2$pages$EndDateTime, file="temp.xlsx")
data <- data.table(json_data2$pages)
write.csv(data, file="temp.csv")

######## Alternative Approach (depending on size of ProductAndServiceUsage.json file) ########

install.packages("rjson")
library("rjson")

json_file <- "ProductAndServiceUsage.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
# then extract dates using a for loop
