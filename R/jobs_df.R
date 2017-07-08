#' jobs_df Function
#'
#' This function returns the list of Jobs from Indeed.com in a dataframe.
#' @param search.keyword Key word to search the site indeed.com.
#' @param search.location location of job search.
#' @export
#' @examples
#' jobs_df()



jobs_df <- function(search.keyword, search.location) {


  #First find the total number of jobs and store it in variable 'Jobcount'
  first_url_link <-  paste0('https://www.indeed.com/jobs?q=',search.keyword,'&l=',search.location,'&start=0') 
  
  
  first_query <- read_html(first_url_link)
  
    
  #First check how many jobs are given by the  search result
  totalJobs <- first_query %>% 
    html_node("div#searchCount") %>%
    html_text()
  
  #totalJobs <- str_sub(totalJobs, start= -3)
  
  totalJobs <- sub(".*of ", "", totalJobs)

  Jobcount <- as.numeric(gsub(",", "", totalJobs))


  print(paste0("Creating Dataframe of ", Jobcount, " jobs found for '", search.keyword, "' in '", search.location, "' ..... "))

  url_link <- paste0('https://www.indeed.com/jobs?q=',search.keyword,'&l=',search.location,'&start=') 

  JobSearch <- data.frame(0)

  JobSearch <- data.frame(Date     = character(0),
                          Title    = character(0),
                          Company  = character(0),
                          Location = character(0),
                          Summary  = character(0),
                          url      = character(0))




  for(i in 0:Jobcount)
    {
  
      full_url_link <- paste0(url_link,i*10)

      indeed <- read_html(full_url_link)
  
  
      Title <- indeed %>%     
        html_nodes("h2.jobtitle") %>%
        html_text()
  
  
      Company <-  indeed %>% 
        html_nodes("span.company") %>%
        html_text()
  
  
      Location <- indeed %>% 
        html_nodes("span.location") %>%
        html_text()
  
      Summary <-  indeed %>% 
        html_nodes("span.summary") %>%
        html_text()
  
      url <- indeed %>% # feed `main.page` to the next step
        html_nodes("h2 a") %>% # get the CSS nodes
        html_attr("href") # extract the URLs
  
  
      Title    <- trimws(str_replace_all(Title, "[\r\n]" , ""))
      Company  <- trimws(str_replace_all(Company, "[\r\n]" , ""))
      Location <- trimws(str_replace_all(Location, "[\r\n]" , ""))
      Summary  <- trimws(str_replace_all(Summary, "[\r\n]" , ""))
      url      <- trimws(str_replace_all(url, "[\r\n]" , ""))
  
      url <- paste0('www.indeed.com',url)
  
  
      #'try' because in case of errors - the tuples with errors will be ignored.    
      try(JobPerPage <- data.frame(Sys.Date(), Title, Company, Location, Summary, url))
      try(JobSearch <- rbind(JobSearch, JobPerPage))
  
    }


  JobSearch <- subset(JobSearch, !duplicated(JobSearch$url))

  return (JobSearch)

}