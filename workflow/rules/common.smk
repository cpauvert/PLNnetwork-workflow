from snakemake.utils import validate

##### load config and validate  #####

# Default is the test data trichoptera from R package PLNmodels
configfile: "config.yaml"
validate(config, schema="../schemas/config.schema.yaml")
    

