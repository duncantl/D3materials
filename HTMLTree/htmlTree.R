library(XML)

u = "http://cdec.water.ca.gov/cgi-progs/queryMonthly?MRC"
if(!exists("doc") || docName(doc) != u)
 doc = htmlParse(u, encoding = "UTF8")

library(RJSONIO)

tbl = getNodeSet(doc, "//table")[[1]]

removeNodes(tbl[ 4:xmlSize(tbl)])

source("htmlTreeFuns.R")
tr = mkTree(xmlParent(tbl))
cat(toJSON(tr), file = "htmlTreeData.json", sep = "\n")

tr = mkTree(tbl)
cat(toJSON(tr), file = "htmlTreeData_tableOnly.json", sep = "\n")
