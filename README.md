# JobsInR 
An R package to extract information from popular job site indeed.com


## Dependencies

- rvest
- stringr


## Installation

the package can be installed with [devtools](https://github.com/hadley/devtools) as: 

```{r}
# install.packages("devtools")
devtools::install_github("gpoudel/JobsInR")

#Also do not forget to install/load dependencies
#install.packages('rvest')
#install.packages('stringr')

library('JobsInR')
library('rvest')
library('stringr')
```

## Functions

As of now the package has the following functions:

#### 1. jobs_count(search.keyword, search.location)
 This function returns the total number of jobs available.
 
 Eg: 
 ```{r}
 jobs_count('python', 'texas')
 [1] 2693
```


#### 2. jobs_df(search.keyword, search.location)
 This function returns a dataframe. The datafrmae consists of following columns 
  * Date
  * Title
  * Company
  * Location
  * Summary
  * URL
  
  
 Eg: 
 ```{r}
 delphi_texas <- jobs_df('delphi', 'texas')
```
