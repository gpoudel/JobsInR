#' jobs_count Function
#'
#' This function returns the total number of Jobs from Indeed.com.
#' @param search.keyword Key word to search the site indeed.com.
#' @param search.location location of job search.
#' @export
#' @examples
#' jobs_count()



jobs_count <- function(search.keyword, search.location) {
  
  
  first_url_link <-  paste0('https://www.indeed.com/jobs?q=',search.keyword,'&l=',search.location,'&start=0') 
  
  
  first_query <- read_html(first_url_link)
  
    
  #First check how many jobs are given by the  search result
  totalJobs <- first_query %>% 
    html_node("div#searchCount") %>%
    html_text()
  
  #totalJobs <- str_sub(totalJobs, start= -3)
  
  totalJobs <- sub(".*of ", "", totalJobs)

  Jobcount <- as.numeric(gsub(",", "", totalJobs))
  
  return(Jobcount)
  
}

