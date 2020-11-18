#  Infer the networks with PLNnetwork()
# 2020-11-04
# Charlie Pauvert

# Sink the stderr and stdout to the snakemake log file
# https://stackoverflow.com/a/48173272
log.file <- file(snakemake@log[[1]], open = "wt")
sink(log.file)
sink(log.file, type = "message")

library(PLNmodels)

# Prepare arguments (no matter the order)
args <- list(
  formula = as.formula(snakemake@params[["formula"]]),
  data = readRDS(snakemake@input[[1]])
)

# Check if extra params are passed
if (length(snakemake@params) > 0) {
  # Keeping only the named elements of the list for do.call()
  extra <- snakemake@params[names(snakemake@params) != "" & names(snakemake@params) != "formula"]
  # Set the threads number in case of option override
  if (is.null(extra[["control_main"]][["cores"]])) {
    extra <- c(
      extra,
      list(control_main = list(
        cores = snakemake@threads
      ))
    )
  }
  # Add them to the list of arguments
  args <- c(args, extra)
} else {
  message("No optional parameters. Using defaults parameters from PLNmodels::PLNnetwork()")
}

# Store the inferred networks as RDS
data <- do.call(PLNnetwork, args)

# Store the output as RDS file
saveRDS(data, snakemake@output[["models"]], compress = T)

# Write the plot
library(ggplot2)
ggsave(snakemake@output[["plot"]], data$plot(), width = 4, height = 3, dpi = 300)
saveRDS(data$criteria, snakemake@output[["table"]], compress = T)

# Proper syntax to close the connection for the log file
# but could be optional for Snakemake wrapper
sink(type = "message")
sink()
