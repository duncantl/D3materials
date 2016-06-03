
ds = list(first = data.frame(id = LETTERS[1:5], val = seq(2, length = 5, by = 20), stringsAsFactors = FALSE),
          second = data.frame(id = LETTERS[c(1, 4, 7, 8, 9, 10)], val = seq(100, length = 6, by = 20), stringsAsFactors = FALSE),
          third = data.frame(id = LETTERS[c(1, 4, 6, 8)], val = seq(20, length = 4, by = 20)), stringsAsFactors = FALSE)

setdiff(ds$second$id, ds$first$id)
# [1] "G" "H" "I" "J"
setdiff(ds$first$id, ds$second$id)
#[1] "B" "C" "E"
intersect(ds$first$id, ds$second$id)
#[1] "A" "D"

setdiff(ds$third$id, ds$second$id)
#[1] "F"
setdiff(ds$second$id, ds$third$id)
#[1] "G" "I" "J"
intersect(ds$second$id, ds$third$id)
#[1] "A" "D" "H"

library(RJSONIO)

mapply(function(name, file, data)
        cat("var", name, "=", toJSON(data, byrow = TRUE), ";", file = file),
       names(ds), sprintf("%s.json", names(ds)), ds)
