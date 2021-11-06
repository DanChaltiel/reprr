

#' init_packages
#'
#' @param pkgs character vector of the packages used in your project
#'
#' @import tidyverse
#' @import glue
#' @return nothing
#' @export
#'
#' @examples
#' init_packages(c("crosstable", "dplyr", "officer"))
init_packages = function(pkgs){
  pkgs = c("crosstable", "dplyr", "officer") %>% set_names() #TODO utiliser ellipse
  # pkgs = c("crosstable", "dpddlyr", "offddicer") %>% set_names()
  # packageVersion("dplyr")
  
  
  is_missing = map_lgl(pkgs, ~length(find.package(.x, quiet=TRUE))==0)
  if(any(is_missing)){
    x = names(is_missing[is_missing])
    x = paste(x, collapse=", ")
    stop("Some packages are not installed: ", x)
  }
  
  cur_vers = pkgs %>% map(packageVersion) %>% map_chr(as.character)
  
  txt_vers = cur_vers %>% 
    imap_chr(~glue("devtools::install_version(package = {.y}, version = '{.x}')"))
  
  txt = c(
    "#This file lists all the commands you would need to run this project again using the exact same package version.", 
    "#Running this file all at once is not recommended as most packages respect backward compatibility. ", 
    "#You should try to find which one is messing with your project and install only this one.", 
    "", 
    "#You will first need `devtools` to install some old versions", 
    'if(!require("devtools")) install.packages("devtools")', 
    "", 
    "#Then, you can install all these packages:", 
    txt_vers, 
    "", 
    "#Keep in mind that this might not list all the dependencies of the above mentioned packages.", 
    "#If one of them have a dependency that breaks backward compatibility, then the project might still be broken.", 
    "", 
    "#This file was generated using the `reprr` package.", 
    "#https://github.", 
    ""
  )
  
  
  writeLines(txt, "init_packages.R")
  
}

