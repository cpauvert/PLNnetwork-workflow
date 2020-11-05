#  Plot a network inferred by PLNnetwork
# 2020-11-05
# Charlie Pauvert

# Sink the stderr and stdout to the snakemake log file
# https://stackoverflow.com/a/48173272
log.file <- file(snakemake@log[[1]], open = "wt")
sink(log.file)
sink(log.file, type = "message")

library(ggraph)

# Read the igraph object from RDS
net <- readRDS(snakemake@input[[1]])

# Plot the entire network
pnet <- ggraph(net, layout = "linear", circular = T) +
  geom_edge_arc(aes(color = weight > 0), alpha = 0.7, width = 3) +
  geom_node_label(aes(label = name), fill = "black", color = "white") +
  scale_edge_color_manual(
    values = c("FALSE" = "firebrick", "TRUE" = "dodgerblue"),
    labels = c("FALSE" = "Negative", "TRUE" = "Positive"),
    name = "Sign", guide = F
  ) +
  coord_fixed(ylim = c(-1.1, 1.1), xlim = c(-1.1, 1.1)) + theme_void()

# Save plot
library(ggplot2)
ggsave(snakemake@output[[1]], pnet, width = 90, height = 90, units = "mm", dpi = 300)

# Proper syntax to close the connection for the log file
# but could be optional for Snakemake wrapper
sink(type = "message")
sink()
