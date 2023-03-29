![](demo.png)

## Requirement

required_lib <- c( "tidyverse", "yaml", "seqinr", "rjson", "zoo", "coronavirus" )


```
 [1] coronavirus_0.4.0 zoo_1.8-11        lubridate_1.8.0  
 [4] rjson_0.2.21      seqinr_4.2-16     forcats_0.5.1    
 [7] stringr_1.4.0     dplyr_1.0.10      purrr_0.3.4      
[10] readr_2.1.2       tidyr_1.2.0       tibble_3.1.8     
[13] ggplot2_3.3.6     tidyverse_1.3.2   yaml_2.3.5 
```


## RMD file

- __required:__ Table[1-3/Omicron].csv, sequencing.csv, R_region.csv, postNS_metadata_PH, _logo.jpg_



## Scripts


#### 1. metadata.R 



- __input:__ `metadata_gisaid_PH.tsv`, (1/)`redcap_metadata.strain.formatted.csv`, (1/)`redcap_formatted.fasta`, `redcap_metadata.csv`, (5/)`redcap_gisaid.lineages.with_all_traits.with_phylotype_traits.csv`

- __out:__ `redcap_only.fasta`, `variant.txt`, `metadata_PH.tsv`
 

#### 2. DOH_data.R

- __input:__ `information_batch_x.csv`

- __out:__ `case_daily_region.csv`



#### 3. post_ns.R

A dry run to make sure there's no additional info to the metadata. 

- __input:__ `metadata_PH.tsv`

- __out:__ `postNS_metadata_PH.csv`



#### 4. table1/table2/table3/table_Omicron

- __input:__ `postNS_metadata_PH.csv`, `previous postNS_meta`

- __usage:__ Rscript [_code_ e.g. table_1.R] [_period1_ e.g. 2022-12-01] [_period2_ e.g. 2023-02-28]



#### 5. jhu_data.R

- __out:__ `case_JHU_PH.csv`



#### 6. Rt.R

- __input:__ `case_daily_region.csv`

- __out:__ `R_region.csv`


#### 7. sequencing.R

- __input:__ `case_JHU_PH.R`, `postNS_metadata_PH.R`

- __out:__ `sequencing.csv`


