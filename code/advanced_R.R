library(tidyverse)
library(readr)


### if-else -------
x <- runif(1, 0, 10) #random x between 0, 10
if(x>3) {
  y <- 10 #y dependent on the answer of x
} else {
  y <- 0
}




### for loops ------
num <- rnorm(10) #random numbers 10
for (i in 1:10) { 
  print(num[i]) #print all of the numbers 
}

let <- c("a", "b", "c", "d") #same as above, slightly differnet
for (i in 1:4) {
  print(let[i])
}

#nested for-loops
x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}

### next ------
for(n in 1:100) {
  if(n <= 20) {
    next
  }
}

### break ------
for(n2 in 1:100) {
  print(n2)
  if(n2 > 20) {
    break  
  }     
}


### Functions ---------
#Download data from RStudio
if(!file.exists("data/2016-07-20.csv.gz")) {
  download.file("http://cran-logs.rstudio.com/2016/2016-07-20.csv.gz", 
                "data/2016-07-20.csv.gz") #saved in the download folder
}

cran <- read_csv("data/2016-07-20.csv.gz", col_types = "ccicccccci") #character / integer
cran %>% 
  filter(package == "filehash") %>% 
  nrow

num_download <- function(pkgname, date) {
  ## Construct web URL
  year <- substr(date, 1, 4)
  src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                 year, date)
  
  ## Construct path for storing local file
  dest <- file.path("data", basename(src))
  
  ## Don't download if the file is already there!
  if(!file.exists(dest))
    download.file(src, dest, quiet = TRUE)
  
  cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
  cran %>% filter(package == pkgname) %>% nrow
}
