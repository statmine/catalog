library(cbsodataR)
library(dplyr)
library(jsonlite)

black_list <- readLines("blacklist.txt")

update_catalog <- function(tl, la="en"){
  catalog <- 
    tl %>% 
    filter( Language == la
          , OutputStatus %in% c("Regulier","Regular")
          , !(Identifier %in% black_list)
          ) %>% 
    select(name=Identifier, title=Title, description=Summary, updated=Updated)
  
  catalog %>% 
    write.csv(paste0("../catalog_",la,".csv"), row.names = FALSE)
  
  catalog %>% 
    jsonlite::toJSON() %>% 
    writeLines(paste0("../catalog_",la,".json"))
  
  invisible(tl) # handy for chaining...
}

tl <- get_table_list()
update_catalog(tl, la="en")
update_catalog(tl, la="nl")