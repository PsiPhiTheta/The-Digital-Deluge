# T Hollis (CSC2552, University of Toronto) -v2.1
#     - Purpose: Analyse social network graph data
#     - Bugs & issues: no bugs, no issues, no warnings

# --- OPTION 1: Import from graphml -----------------

fb <- read_graph("fb.graphml", format = "")
fbNoPics <- read_graph("fbNoPics.graphml", format = "graphml")

# --- OPTION 2: Import from csv -----------------

dat = read.csv('SocialNetPlot.csv', sep=";", stringsAsFactors = FALSE)
mat = as.matrix(dat)

# --- Plotting -----------------

#various options available here, you can use the igraph package or use Gephi
