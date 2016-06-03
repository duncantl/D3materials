pubs = readRDS("PublicationSubjectAreas.rds")

el = as_edgelist(graph.adjacency(pubs > 0))

el = as.data.frame(el, stringsAsFactors = FALSE)

d3SimpleNetwork(el, file = "subjectAreasGraph.html")

d3SimpleNetwork(el, file = "subjectAreasGraph.html", linkDistance = 300, width = 1000, height = 1000)


# Put colors on the edges to indicate counts
# Tooltips on the edges
