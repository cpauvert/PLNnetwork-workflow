## Code

- [x] ~~Ask in config.yaml if stability has to be performed.~~ Can be deduced from criteria
- [ ] Set the stability threshold as an option deduced from the criteria: `StARS_0.95`
- [ ] **Validate** the config.yaml to correct for typos in criteria names and potential threshold passed
- [ ] Provide custom number of bootstraps (set to 20 by default)

## Visualisation

- [x] Report in html with snakemake
- [x] Set the final plot with r-ggraph env (is in conda-forge)
- [ ] Set an interactive plot in the report? Just like the rule graph (check [hundo](https://github.com/pnnl/hundo)?)
- [ ] Add the histogram of edge stability distribution
