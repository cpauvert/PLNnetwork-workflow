#  Prepare data for PLNnetwork()
# 2020-11-04
# Charlie Pauvert

# Sink the stderr and stdout to the snakemake log file
# https://stackoverflow.com/a/48173272
log.file <- file(snakemake@log[[1]], open = "wt")
sink(log.file)
sink(log.file, type = "message")

library(PLNmodels)

# Prepare arguments (no matter the order)
args <- snakemake@input[names(snakemake@input) != ""]

# Read RDS files
args <- sapply(args, readRDS)

# Check if extra params are passed
if (length(snakemake@params) > 0) {
  # Keeping only the named elements of the list for do.call()
  extra <- snakemake@params[names(snakemake@params) != ""]
  # Add them to the list of arguments
  args <- c(args, extra)
} else {
  message("No optional parameters. Using defaults parameters from PLNmodels::prepare_data()")
}

# Prepare data for PLNnetwork
data <- do.call(prepare_data, args)

# Store the output as RDS file
saveRDS(data, snakemake@output[[1]], compress = T)

# Proper syntax to close the connection for the log file
# but could be optional for Snakemake wrapper
sink(type = "message")
sink()
