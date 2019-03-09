# T Hollis (CSC2552, University of Toronto) -v2.1
#     - Purpose: Analyse Telegram GDPR message data
#     - Bugs & issues: no bugs, no issues, no warnings

# Step 0. Load packages
install.packages("ngram")
library(ngram)
install.packages("stringr")
library(stringr)

# Step 1. Import csv file
data <- paste(readLines("messages56.html"), collapse="\n") # only ~500KB of messages at a time

# Step 2. Clean text
data2 <- tolower(toString(data))
dataClean <- stringr::str_replace_all(data2,"[^a-zA-Z\\s]", " ")
dataCleanSpaced <- stringr::str_replace_all(dataClean,"[\\s]+", " ")

# Step 3. Analyse text using ngram models
ng2 <- ngram(dataCleanSpaced, n = 2) # Bigrams
ng3 <- ngram(dataCleanSpaced, n = 3) # Trigrams
ng5 <- ngram(dataCleanSpaced, n = 5) # 5-grams

print(ng2, output="truncated")
print(ng2, output="full")
get.phrasetable(ng2)
ngram::ngram_asweka(dataCleanSpaced, min=2, max=3)

babble(ng = ng2, genlen = 100)
babble(ng = ng3, genlen = 100)
babble(ng = ng5, genlen = 100)

