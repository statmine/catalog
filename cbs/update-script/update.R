library(cbsodataR)
library(dplyr)
library(jsonlite)

update_catalog <- function(tl, la="en"){
  catalog <- 
    tl %>% 
    filter(Language == la) %>% 
    filter(OutputStatus %in% c("Regulier","Regular")) %>% 
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