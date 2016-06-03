print(load("15Sessions.rda"))

sen = ms[[length(ms)]]
class(sen)
dim(sen)
colnames(sen)


library(igraph)

Threshold = 30
m = sen > Threshold
el = as_edgelist(graph.adjacency(m))

el = as.data.frame(el, stringsAsFactors = FALSE)

counts = sen[ as.matrix(el) ]
ids = colnames(m)
Links = data.frame(source = match(el[,1], ids) - 1L,
                   target = match(el[,2], ids) - 1L,
                   value = as.integer(cut(counts, quantile(counts, c(0, .2, .4, .6, .8, 1)))))

load("~/Data/GovTrack/legislators.rda")

i = match(ids, people$govtrack_id)


#Note how we map the nodes for the colors.

Nodes = data.frame(name = paste(people[i, "first_name"], people[i, "last_name"]),
                   group = as.integer(factor(people[i,"party"])),
                   size = rowSums(m[ids, ids]))

library(networkD3)
# Different from d3Network package.

g = forceNetwork(Links = Links, Nodes = Nodes, Source = "source",
                  Target = "target", Value = "value", NodeID = "name",
                  Nodesize = "size",
                  radiusCalculation = "Math.sqrt(d.nodesize)+6",
                  Group = "group", opacity = 0.4, legend = TRUE,
                  charge = -400, linkDistance = 200, zoom = TRUE,
                   colourScale = JS('d3.scale.ordinal().domain([1, 2, 3]).range(["#00f","#0f0","#f00"])') )


# Just put the party name in the data frame and use a  more intuitive mapping for the color scale.
# Also change the opacity.

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




