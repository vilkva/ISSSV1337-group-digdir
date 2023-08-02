#### document: use Light House to retrieve accessibility score####

### To retrieve the accessibility score, run this code

get_accessibilityscore <- function(list_of_pages,
                                   view = FALSE,
                                   keepFile = FALSE) {
  path_list <- list()
  
  for (page in list_of_pages) {
    
    # Call the lighthouse module
    page_path <- gsub("http(s)?\\:\\/\\/", "", page)
    path <- paste0("./", gsub("\\/$", "", page_path),
                   "_", Sys.Date(), "_", format(Sys.time(), "%H_%M_%S"),
                   ".report.html")
    
    sys_call <- paste0("lighthouse ",
                       page,
                       " --output-path ",
                       path,
                       " --chrome-flags='--headless'",
                       if (view) " --view",
                       " --only-categories=accessibility")
    s <- system(sys_call, intern = TRUE)
    
    path_list <- append(path_list, path)
  }
  
  score_table <- data.frame(Accessibility = character(), Page = character())
  
  for (path in path_list) {
    rawHTML <- paste(readLines(path), collapse = "\n")
    
    scores <- as.data.frame(stringr::str_extract_all(rawHTML,
                                                     '."(accessibility)","score":[0-9]{1,3}.?[0-9]{0,2}'))
    scores <- as.data.frame(gsub('"(accessibility)","score":', '', scores))
    scores$Page <- as.character(page)
    output <- paste0(getwd(), gsub("\\.\\/", "\\/", path))
    colnames(scores) <- c("Accessibility", "Page")
    rownames(scores) <- as.character(output)
    
    score_table <- rbind(score_table, scores)
    
    if (!keepFile) {
      file.remove(output)
    }
  }
  
  return(score_table)
}

### Function to get accessibility scores for a list of URLs
get_accessibilityscores <- function(urls) {
  scores <- data.frame(Page = character(), AccessibilityScore = numeric(),
                       stringsAsFactors = FALSE)
  for (url in urls) {
    accessibility_score <- get_accessibilityscore(url)
    new_row <- data.frame(Page = url, AccessibilityScore = accessibility_score)
    scores <- rbind(scores, new_row)
    Sys.sleep(10) # Wait for 10 seconds before fetching data for the next URL
  }
  return(scores)
}

# List of 3 URLs
urls <- c("https://www.kanalbaatene.no", "https://www.srb.no", "https://www.haldenkanalen.no")

# Get accessibility scores for the URLs and save them to a data frame
accessibility_scores <- get_accessibilityscores(urls)

# View the data frame with accessibility scores
View(accessibility_scores)

### The accessibility scores indicate that 'kanalbaatene' received a score of 0.79, 'srb' received a score of 0.82, and 'haldenkanalen' received the highest score of 0.9. 

