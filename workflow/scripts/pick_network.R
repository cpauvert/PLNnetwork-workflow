#  Pick a network from the fits using criteria
# 2020-11-05
# Charlie Pauvert

# Sink the stderr and stdout to the snakemake log file
# https://stackoverflow.com/a/48173272
log.file <- file(snakemake@log[[1]], open = "wt")
sink(log.file)
sink(log.file, type = "message")

library(PLNmodels)

# Prepare arguments (no matter the order) and read RDS files
args <- list(
  Robject = readRDS(snakemake@input[[1]]),
  crit = snakemake@wildcards[["criteria"]]
)

# Check if extra params are passed
if (length(snakemake@params) > 0) {
  # Keeping only the named elements of the list for do.call()
  extra <- snakemake@params[names(snakemake@params) != ""]
  # Add them to the list of arguments
  args <- c(args, extra)
} else {
  message("No optional parameters. Using defaults parameters from PLNmodels::getBestModel()")
}
save.image()
# Prepare data for PLNnetwork
picked_network <- do.call(getBestModel, args)

# Store the output as RDS file
saveRDS(picked_network, snakemake@output[["pln"]], compress = T)

# Create the igraph object and save
net <- picked_network$plot_network(type = "partial_cor", plot = F, edge.color = c("dodgerblue", "firebrick"))
if ("StARS" %in% snakemake@config[["criteria"]]) {
  library(igraph)
  # Extraction of the edge selection frequency
  # for the penalty chosen in the picked network
  probs <- extract_probs(args[["Robject"]], penalty = picked_network$penalty, format = "vector")

  # Add the selection frequency as an igraph edge attribute
  E(net)$prob <- probs[as_ids(E(net))]
}
saveRDS(net, snakemake@output[["igraph"]], compress = T)

# Proper syntax to close the connection for the log file
# but could be optional for Snakemake wrapper
sink(type = "message")
sink()
