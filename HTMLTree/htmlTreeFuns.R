
mkTree =
function(node)
{
  ats = if(inherits(node, "XMLInternalTextNode")) {
           isLeaf = TRUE
           XML:::trim(paste(xmlValue(node), collapse = ""))
        } else {
            isLeaf = FALSE
            ats = xmlAttrs(node)
            ats = paste(names(ats), ats, sep = "=", collapse = " ")
        }
  list(name = xmlName(node),
       children = unname(lapply(xmlChildren(node), mkTree)),
       attrs = ats,
       isLeaf = isLeaf)
}

