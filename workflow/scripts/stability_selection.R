#  Multithreaded stability selection
# 2020-11-05
# Charlie Pauvert

# Sink the stderr and stdout to the snakemake log file
# https://stackoverflow.com/a/48173272
log.file <- file(snakemake@log[[1]], open = "wt")
sink(log.file)
sink(log.file, type = "message")

library(PLNmodels)

# Load the PLNnetwork fit models
models <- readRDS(snakemake@input[[1]])

# Prepare arguments (no matter the order) and read RDS files
args <- list(
  Robject = models,
  mc.cores = snakemake@threads
)

# Check if extra params are passed
if (length(snakemake@params) > 0) {
  # Keeping only the named elements of the list for do.call()
  extra <- snakemake@params[names(snakemake@params) != ""]
  # Add them to the list of arguments
  args <- c(args, extra)
} else {
  message("No optional parameters. Using defaults parameters from PLNmodels::stability_selection()")
}

# Perform network inference on subsamples
# The object models is updated
do.call(stability_selection, args)

# Store the output as RDS file
saveRDS(models, snakemake@output[["models"]], compress = T)

# Save the stability path plot
library(ggplot2)
ggsave(snakemake@output[["plot"]], models$plot_stars(), width = 4, height = 3, dpi = 300)

# Proper syntax to close the connection for the log file
# but could be optional for Snakemake wrapper
sink(type = "message")
sink()
