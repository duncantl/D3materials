print(load("15Sessions.rda"))

sen = ms[[length(ms)]]
class(sen)
dim(sen)
colnames(sen)


tmp = list(packageNames = colnames(sen),
           matrix = unname(sen))

library(RJSONIO)
cat("var data = ",
    toJSON(tmp), ";\n", file = "senateWheel.json")


# How to put the tooltips for the person's name
#  Color them red or blue
#
#   Identify the bills they actually co-sponsored.


library(igraph)
Threshold = 30
m = sen > Threshold
el = as_edgelist(graph.adjacency(m))

#el = as.data.frame(el, stringsAsFactors = TRUE)
el = as.data.frame(el, stringsAsFactors = FALSE)

library(d3Network)
d3SimpleNetwork(el, file = "senateGraph.html", linkDistance = 300, width = 1500, height = 1000, charge = -800)



# networkD3

ids = colnames(m)
counts = sen[ as.matrix(el) ]
Links = data.frame(source = match(el[,1], ids) - 1L,
                   target = match(el[,2], ids) - 1L,
                   value = as.integer(cut(counts, quantile(counts, c(0, .2, .4, .6, .8, 1)))))


#source("~/Data/GovTrack/funs.R")
#getLegislators()
load("~/Data/GovTrack/legislators.rda")
i = match(ids, people$govtrack_id)


Nodes = data.frame(name = paste(people[i, "first_name"], people[i, "last_name"]),
                   group = as.integer(factor(people[i,"party"])),
                   size = rowSums(m[ids, ids]))



#Nodes - data frame with name, group (Dem/Rep/Ind), size = rowSums(m)
# Links

 forceNetwork(Links = Links, Nodes = Nodes, Source = "source",
                  Target = "target", Value = "value", NodeID = "name",
                  Nodesize = "size",
                  radiusCalculation = "Math.sqrt(d.nodesize)+6",
                  Group = "group", opacity = 0.4, legend = TRUE,
                  charge = -400, linkDistance = 200, zoom = TRUE,
                   colourScale = JS('d3.scale.ordinal().domain([1, 2, 3]).range(["#00f","#0f0","#f00"])') )

# [ "#0000FF", "00FF00", "#FF0000"]
# "foo", "bar", "baz"
# d3.scale.ordinal().domain([1, 2, 3]).range(["#00f","#0f0","#f00"])


Nodes1 = data.frame(name = paste(people[i, "first_name"], people[i, "last_name"]),
                   group = people[i,"party"],
                   size = rowSums(m[ids, ids]))



 forceNetwork(Links = Links, Nodes = Nodes1, Source = "source",
                  Target = "target", Value = "value", NodeID = "name",
                  Nodesize = "size",
                  radiusCalculation = "Math.sqrt(d.nodesize)+6",
                  Group = "group", opacity = 0.9, legend = TRUE,
                  charge = -400, linkDistance = 200, zoom = TRUE,
                  colourScale = JS('d3.scale.ordinal().domain(["Democrat", "Independent", "Republican"]).range(["#00f","#0f0","#f00"])') )





###############
# co-occurrence matrix
#
# Same format as miserables.json

# list(nodes = list (  list(name = "", group = ), .... ) ,
#       links = list( list(source = num, target = num, value = num) .... ))

Nodes$party = people$party[i]
Nodes$govtrack_id = people$govtrack_id[i]

cat(jsonlite:::toJSON( list(nodes = Nodes, links = Links)), file = "senateMatrix.json")

# Or
# cat(toJSON( list(nodes = Nodes, links = Links), byrow = TRUE), file = "senateMatrix.json")





