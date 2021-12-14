## Methods

### 1. Nextstrain build

All available SARS-CoV2 genomic sequences and their metadata were downloaded from GISAID. Metadata of viruses isolated in the Philippines were extracted from the full data set to correct the _division_ column. Both genomic and metadata were merged with the same type of data available from the GECO REDcap project. We subsequently took advantage of the Nextstrain pipeline to reconstruct phylogenetic relationship and data visualization with a combined data set containing both global and Philippine genomic sequences. A customized workflow focusing on Philippine SARS-CoV2 isolates was designed to subsample and analyze input data, with the existing filtering criteria including sequence length and missing information (see details [here](https://github.com/nextstrain)). The workflow would subsample 25 Philippine isolates per division per month, in addition to a global data set subsampled from sequences isolated from other countries which genetically similar to the available Philippine isolates. The analyzed results were visualized by Auspice. 


The goal to conduct the Nextstrain pipeline is to understand temporal patterns in SARS-CoV2 lineage and geographical dispersal with a focus on viruses in the Philippines, and therefore the individual sequence and its metadata is not of our interest at this moment. Considering heterogeneous sampling across administrative regions (see [here](https://geco-ph.github.io/GECO-covid/#SARS-CoV-2_variants_detected_by_administrative_region)) and the large amount of closely related samples collected from the same epidemic clusters, we subsampled the input data at a scale of administrative region each month to obtain a representative data set. It is also important to keep the computational process feasible when the number of isolated sequences grows. If you would like to see a big tree with all available samples, we encourage readers to visit our results presented on [Microreact](https://www.geco-seqlab.org/micro-react.html).


### 2. Grapevine-anywhere and QC criteria

Sequences submitted to the REDCap depository for GECO will be subject to _Grapevine-anywhere_ pipeline. The pipeline will annotate each SARS-CoV2 genomic sequence with names of different classification methods (e.g. Pango or PH cluster) if the sequence passes basic rules for quality control.  Intuitively, a short sequence (sequence length) or a sequence with too many 'N' (coverage) should be less informative and sometimes problematic for lineage designation, and so the criteria are set to filter out low quality sequences in advance to  further phylogenetic analyses. Bioinformatic pipelines also tend to remove entries with identical information (deduplication). Default filtering parameters for our _Grapevine-anywhere_ pipeline can be found [here](https://github.com/GECO-PH/grapevine-anywhere/blob/main/config.yaml).



