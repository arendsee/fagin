**This program is under heavy development, stability coming soon**

# Fagin

A pipeline for the classification of orphans into origin classes using a syntenic filter.

# Input

 The following is required

 - Phylogeny for all included species
 - Name of the focal species
 - Synteny map for the focal species versus each other species
 - For each species
   - GFF file (must at least include gene models)
   - Full genome (GFF reference)

# Pipeline

 - Identify target genes that overlap the search space.
 - Search the query protein against the overlapping target gene's ORFs
 - Search the query gene DNA against the search interval DNA sequences
 - Predict ancestor states

# Output

   A PDF file describing the results of the run.

 - The phylogenetic tree of all species in the pipeline
 - Genome summary for each species 
 - Overall statistics for classifications
 - Visualizations of overall statistics
 - Origin page for each orphan gene

# Running Fagin

 1. `./configure.sh` 
 2. Fill in generated config scripts
 3. `make load && make test && make run`

## 1. Run configure script

```
./configure.sh
```

This script will
  - check all dependencies, installing locally necessary
  - check all required R libraries, and install if possible
  - build basic config files

## 2. Setup config files

Fill in missing fields in `preconfig.sh` and `runconfig.R`. Details for each
required field are in the config files.

## 3. Run the analysis

```
make load && make test && make run
```


# TODO

## R Code

 - [x] code for importing and iterating through all data
 - [x] classify focal species genes against each search interval
 - [x] merge search interval classifications
 - [x] get final gene class from species class vector
 - [x] statistically summarize results
 - [x] visualize results
 - [ ] **remove hard-coded assumption of depth=3 species trees**
 - [ ] generalize from 'orphan' to 'query'
 - [ ] prepare report for each query
 - [ ] add orthology statistics
 - [ ] print all intermediate data
 - [ ] modularize analyses, e.g. N-string, indel, CDS overlap, etc.
 - [ ] build graph for assignment tree
