# PLNnetwork-workflow
Infer a network from count data within Snakemake using a sparse Poisson lognormal model (PLNnetwork)

This [Snakemake](https://snakemake.readthedocs.io/) workflow provides the means to fit a sparse Poisson lognormal model for sparse covariance inference for counts (aka PLNnetwork). This model is a subset of a nice collection of models bundled into the R package [PLNmodels](https://github.com/jchiquet/PLNmodels). The R version and package dependencies are contained within `conda` environment for reproducibility.
The R commands are splitted as Snakemake rules to be able to start again on error and follow up the dependencies between the created files (such as RDS files for the models or bootstraps).

## Usage

The organisation of this workflow was adapted from the template of [snakemake workflows](https://github.com/snakemake-workflows/docs).

### Step 1: Obtain a copy of this workflow

1. Create a new github repository using this workflow [as a template](https://help.github.com/en/articles/creating-a-repository-from-a-template).
2. [Clone](https://help.github.com/en/articles/cloning-a-repository) the newly created repository to your local system, into the place where you want to perform the data analysis.

### Step 2: Configure workflow

Configure the workflow according to your needs via editing the `config.yaml` file in the `config/` folder.

### Step 3: Install Snakemake

Install Snakemake using [conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html):

    conda create -c bioconda -c conda-forge -n snakemake snakemake

For installation details, see the [instructions in the Snakemake documentation](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html).

### Step 4: Execute workflow

Activate the conda environment:

    conda activate snakemake

Test your configuration by performing a dry-run via

    snakemake --use-conda -n

Execute the workflow locally via

    snakemake --use-conda --cores $N results/PLN/networks.RDS # WIP the target file will be removed

If you have previously installed the dependencies (`R` and `PLNmodels`) for this workflow independently or using the following commands, the `--use-conda` is not necessary:

    conda create -n PLNmodels r-plnmodels
    snakemake -n
