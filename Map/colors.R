rgb =
function(a,b,c)
  grDevices::rgb(a/255, b/255, c/255)

col  = c(
    rgb(247,251,255),    
    rgb(222,235,247),
    rgb(198,219,239),
    rgb(158,202,225),
    rgb(107,174,214),
    rgb(66,146,198),
    rgb(33,113,181),
    rgb(8,81,156),
    rgb(8,48,107))

paste(col, collapse = ", ")

