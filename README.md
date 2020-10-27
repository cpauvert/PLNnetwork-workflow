# PLNnetwork-workflow: infer network from count data within Snakemake

This [Snakemake](https://snakemake.readthedocs.io/) workflow provides the means to fit a sparse Poisson lognormal model for sparse covariance inference for counts (aka PLNnetwork). This model is a subset of a nice collection of models bundled into the R package [PLNmodels](https://github.com/jchiquet/PLNmodels). The R version and package dependencies are contained within `conda` environment for reproducibility.
The R commands are splitted as Snakemake rules to be able to start again on error and follow up the dependencies between the created files (such as RDS files for the models or bootstraps).
