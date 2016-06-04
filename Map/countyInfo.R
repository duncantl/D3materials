library(XML)
library(RCurl)
u = "https://en.wikipedia.org/wiki/List_of_United_States_counties_and_county_equivalents"
txt = getURLContent(u)
tbl = readHTMLTable(txt, stringsAsFactors = FALSE, which = 3)

tbl[[1]] = as.numeric(tbl[[1]])

names(tbl) = c("INCITS", "Name", "State", "Popn", "CoreArea", "StatArea")
write.table(tbl, "countyInfo.tsv", sep = "\t", row.names = FALSE)

if(FALSE) {
  us = fromJSON("us.json")
  us.ids = sapply(us$objects$counties$geometries, `[[`, "id")
  i = match(tbl[[i]], us.ids)
  tbl[is.na(i), 1:3]

  # Also we have 78 fewer entries from wikipedia than are in the json file
  c(length(us.ids), nrow(tbl))
}



