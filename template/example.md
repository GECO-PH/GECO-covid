---
title: "GECO Philippines SARS-CoV-2 Situation Report - 2022 January"
output: 
  html_document:
    df_print: paged
    keep_md: yes
    theme: united
    highlight: tango
    toc: true
    toc_float: true
    toc_depth: 2
  pdf_document: default
editor_options: 
  chunk_output_type: console
---








<style type="text/css">
h1, h2{
  text-align: center;
  font-family: Helvetica;
  font-weight: bold;
}

body{
  margin-top: 75px;
  font-family: Helvetica;
  font-weight: lighter;
  font-size: 14pt;
}

</style>

$~$

## Highlights

$~$

<h4> * Omicron variant accounts for most of the sequences isolated in December, 2021. </h4>

<h4> * Locally circulating Omicron viruses most likely belong to BA.2 lineage. </h4>  

$~$
$~$

## SARS-CoV-2 variants detected in the Philippines 

$~$





<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["WHO label"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Pango lineage"],"name":[2],"type":["chr"],"align":["left"]},{"label":["Classification"],"name":[3],"type":["chr"],"align":["left"]},{"label":["New submission"],"name":[4],"type":["chr"],"align":["left"]},{"label":["Isolated in 4 months"],"name":[5],"type":["chr"],"align":["left"]},{"label":["Total"],"name":[6],"type":["int"],"align":["right"]}],"data":[{"1":"Alpha","2":"B.1.1.7/Q.x","3":"VOC","4":"15 (6.9)","5":"1 (1)","6":"2761"},{"1":"Beta","2":"B.1.351","3":"VOC","4":"9 (4.1)","5":"0","6":"3239"},{"1":"Delta","2":"B.1.617.2/AY.x","3":"VOC","4":"12 (5.5)","5":"42 (40)","6":"3281"},{"1":"Gamma","2":"P.1","3":"VOC","4":"0","5":"0","6":"12"},{"1":"Omicron","2":"B.1.1.529/BA.x","3":"VOC","4":"60 (27.5)","5":"62 (59)","6":"62"},{"1":"B.1.640","2":"B.1.640","3":"VUM","4":"0","5":"0","6":"2"},{"1":"Eta","2":"B.1.525","3":"VUM","4":"0","5":"0","6":"8"},{"1":"Theta","2":"P.3","3":"VUM","4":"0","5":"0","6":"519"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
<strong>Table 1. Number of available sequences by variant in the Philippines as of 20 January 2022.</strong> The variants (VOC/VUM) here only include sequences that present in the GISAID or GECO data base and fulfill the definitions of WHO at the time the report is prepared. *New submission*, new sequences submitted from the last report. *Isolated in 4 months*, sequences isolated from 1 October 2021 to 20 January 2022. Numbers in the parentheses are percentage of the category (%).

$~$

<body>
<small> 

* __VOC (Variant of Concern):__ A SARS-CoV-2 variant that meets the definition of a VOI (see below) and, through a comparative assessment, has been demonstrated to be associated with (a) increase in transmissibility, (b) increase in clinical disease presentation or (c) decrease in effectiveness of public health measures including diagnostics, vaccines, therapeutics.

* __VOI (Variant of Interest):__ A SARS-CoV-2 variant: (a) with genetic changes that are predicted or known to affect virus characteristics such as transmissibility, disease severity, immune escape, diagnostic or therapeutic escape; AND (b) identified to cause significant community transmission or multiple COVID-19 clusters, in multiple countries with increasing relative prevalence alongside increasing number of cases over time. 

* __VUM (Variant Under monitoring):__ A SARS-CoV-2 variant with genetic changes that are suspected to affect virus characteristics with some indication that it may pose a future risk, but evidence of phenotypic or epidemiological impact is currently unclear, requiring enhanced monitoring and repeat assessment pending new evidence.

* __Pango lineage:__ A dynamic SARS-CoV-2 naming system that uses a phylogenetic framework (methods that involve a tree-like structure inferred based on genetic information of viruses) to identify actively spreading lineages. The Pango system is designed to track the transmission and spread of SARS-CoV-2, but does not attempt to identify or define VOCs or VOIs.  

</small>
</body>


$~$

<iframe src="https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=variant&amp;d=frequencies&amp;f_country=Philippines&amp;p=full&amp;sidebar=closed&amp;onlyPanels" width="100%" height="250" data-external="1"></iframe>
<strong>Figure 1. Temporal frequencies of SARS-CoV-2 variants in the Philippines.</strong> The figure is constructed with a subsampled genomic data set from all available sequences ([methods](https://github.com/GECO-PH/GECO-covid/blob/main/supp/methods.md)). A more detailed illustration of SARS-CoV-2 lineages isolated in the country can be visualised by selecting PANGO Lineage as the option for coloring in the control panel (icon on top left/right). __Note__ that the latest available Philippine sequences were isolated on 28 December, 2021, thus the frequencies after the time point could harbor great uncertainty. 

$~$

__Diversity within the Omicron variant__

The two sublineages of the Omicron variant, denoted as BA.1 and BA.2, have been identified in the Philippines since December 2021. Based on the available data, all BA.2 sequences isolated in the Philippines (n=39) were likely originated from the same introduction. These sequences were also identified by the grapevine-anywhere pipeline as a single cluster (PH_137, see *PH specific lineages* section). Phylogenetic relationship of the sublineages of Omicron variant is available [here](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=pango_lineage&d=tree,map,frequencies&f_country=Philippines&label=clade:21K%20%28Omicron%29&p=full&sidebar=closed). Note that the BA.2 viruses do not have 69-70 deletions in the S protein, and therefore the SGTF (S-gene target failure) may not be used to detect the lineage (see *mutations of interest* section).


$~$

__Diversity within the Delta variants__

More than 70 Pango lineages have been found among Delta variants isolated in the Philippines, with >40 sublineages that have more than 2 isolated sequences as of January 2022. Among the sublineages of Delta variant, AY.28 is the most frequently isolated lineage in the Philippines, followed by AY.9.2. Phylogenetic relationship of the sublineages of Delta variant is available [here](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=pango_lineage&d=tree,map,frequencies&f_country=Philippines&label=clade:21A%20%28Delta%29&p=full&sidebar=closed).



$~$
$~$

## SARS-CoV-2 variants detected by administrative region

$~$

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Region"],"name":[1],"type":["chr"],"align":["left"]},{"label":["New submission"],"name":[2],"type":["chr"],"align":["left"]},{"label":["Dominant variant in 4 months"],"name":[3],"type":["chr"],"align":["left"]},{"label":["Isolated in 4 months"],"name":[4],"type":["chr"],"align":["left"]},{"label":["Total"],"name":[5],"type":["int"],"align":["right"]}],"data":[{"1":"NCR","2":"85 (39)","3":"Omicron (88.2)","4":"51 (48.6)","5":"4050"},{"1":"Ilocos","2":"0","3":"-","4":"0","5":"363"},{"1":"CAR","2":"0","3":"-","4":"0","5":"747"},{"1":"Cagayan Valley","2":"0","3":"-","4":"0","5":"984"},{"1":"Central Luzon","2":"3 (1.4)","3":"Omicron (100)","4":"3 (2.9)","5":"968"},{"1":"Calabarzon","2":"90 (41.3)","3":"Delta (78)","4":"41 (39)","5":"2135"},{"1":"Mimaropa","2":"10 (4.6)","3":"Delta (100)","4":"3 (2.9)","5":"345"},{"1":"Bicol","2":"2 (0.9)","3":"Omicron (100)","4":"2 (1.9)","5":"244"},{"1":"Western Visayas","2":"1 (0.5)","3":"Omicron (100)","4":"1 (1)","5":"499"},{"1":"Central Visayas","2":"3 (1.4)","3":"Omicron (100)","4":"3 (2.9)","5":"598"},{"1":"Eastern Visayas","2":"0","3":"Delta (100)","4":"1 (1)","5":"141"},{"1":"Zamboanga Peninsula","2":"0","3":"-","4":"0","5":"417"},{"1":"Northern Mindanao","2":"12 (5.5)","3":"-","4":"0","5":"348"},{"1":"Davao","2":"0","3":"-","4":"0","5":"764"},{"1":"Soccsksargen","2":"0","3":"-","4":"0","5":"200"},{"1":"Caraga","2":"0","3":"-","4":"0","5":"282"},{"1":"BARMM","2":"12 (5.5)","3":"-","4":"0","5":"93"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
<strong>Table 2. Number of available sequences by administrative region in the Philippines as of 20 January 2022.</strong> The variant definition is identical to Table 1 based on the WHO website. *New submission*, new sequences submitted from the last report. *Dominant variant in 4 months*, the major variant isolated from 1 October 2021 to 20 January 2022. A dash indicates no sequence isolated. *Isolated in 4 months*, sequences isolated from 1 October 2021 to 20 January 2022. Numbers next to the dominant variant indicate percentage of the variant in the region, whereas other numbers in the parentheses are percentage of the category.

<body>
<font size="3">
NCR, National Capital Region; CAR, Cordillera Administrative Region; BARMM, Bangsamoro Autonomous Region in Muslim Mindanao. 
</font>
</body>

$~$

<iframe src="https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=variant&amp;d=map&amp;f_country=Philippines&amp;p=full&amp;sidebar=closed&amp;onlyPanels" width="100%" height="600" data-external="1"></iframe>
<strong>Figure 2. Frequencies of SARS-CoV-2 variants by administrative region in the Philippines.</strong> The figure is constructed with a subsampled genomic data set from all available sequences as Figure 1. Frequencies of isolates in a particular time frame can be adjusted with the control panel (icon on top left/right).  


$~$
$~$


## Philippines specific SARS-CoV-2 lineages 

$~$

<iframe src="https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=cluster&amp;d=frequencies&amp;f_source=GECO&amp;onlyPanels&amp;p=full&amp;sidebar=closed" width="100%" height="250" data-external="1"></iframe>
<strong>Figure 3. Temporal frequencies of Philippine lineages (clusters) identified by [Grapevine-anywhere](https://github.com/GECO-PH/grapevine-anywhere).</strong> Each sequence submitted to GECO database would undergo *Grapevine-anywhere* pipeline to detect sustain local transmission. A cluster is defined based on multiple sequences isolated in the Philippines that appeared to descend from the same introductory event on a phylogenetic tree. Phylogenetic relationships of these lineages can be found [here](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=cluster&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed).



$~$


<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Cluster name"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Date first identified"],"name":[2],"type":["chr"],"align":["left"]},{"label":["Pango lineage"],"name":[3],"type":["chr"],"align":["left"]},{"label":["Distribution"],"name":[4],"type":["chr"],"align":["left"]},{"label":["New submission"],"name":[5],"type":["int"],"align":["right"]},{"label":["Isolated in 4 months"],"name":[6],"type":["int"],"align":["right"]},{"label":["Total"],"name":[7],"type":["int"],"align":["right"]}],"data":[{"1":"PH_154","2":"2020-08-18","3":"B.1.351","4":">3 regions","5":"28","6":"42","7":"6135"},{"1":"PH_137","2":"2021-12-19","3":"BA.2","4":"NCR; Calabarzon","5":"33","6":"33","7":"33"},{"1":"PH_150","2":"2021-12-04","3":"BA.1","4":"NCR; Central Visayas","5":"1","6":"3","7":"3"},{"1":"PH_77","2":"2020-12-29","3":"B.1.1.7","4":">3 regions","5":"11","6":"1","7":"2131"},{"1":"PH_101","2":"2021-04-02","3":"B.1.1.519","4":"NCR","5":"0","6":"0","7":"5"},{"1":"PH_105","2":"2021-03-05","3":"C.38","4":"NCR; Caraga","5":"0","6":"0","7":"3"},{"1":"PH_41","2":"2021-02-20","3":"B.1.1.7","4":"Central Visayas; NCR","5":"0","6":"0","7":"3"},{"1":"PH_37","2":"2021-02-18","3":"B.1.1.7","4":"Calabarzon; Central Luzon; Mimaropa","5":"0","6":"0","7":"7"},{"1":"PH_47","2":"2021-02-17","3":"B.1.1.7","4":"Central Luzon; Central Visayas; NCR","5":"0","6":"0","7":"3"},{"1":"PH_34","2":"2021-02-16","3":"B.1.1.7","4":"Central Luzon; NCR","5":"0","6":"0","7":"3"},{"1":"PH_57","2":"2021-02-11","3":"B.1.1.7","4":">3 regions","5":"0","6":"0","7":"47"},{"1":"PH_68","2":"2021-01-27","3":"B.1.1.7","4":"Central Luzon; NCR","5":"0","6":"0","7":"4"},{"1":"PH_62","2":"2021-01-26","3":"B.1.1.7","4":">3 regions","5":"0","6":"0","7":"48"},{"1":"PH_78","2":"2021-01-19","3":"B.1.1","4":">3 regions","5":"0","6":"0","7":"29"},{"1":"PH_55","2":"2021-01-17","3":"B.1.1.7","4":"Central Visayas; NCR; Central Luzon","5":"0","6":"0","7":"5"},{"1":"PH_6","2":"2021-01-15","3":"A.21","4":"NCR; Calabarzon","5":"0","6":"0","7":"3"},{"1":"PH_156","2":"2021-01-09","3":"B.1.525","4":"NCR; Central Luzon; Central Visayas","5":"0","6":"0","7":"6"},{"1":"PH_169","2":"2021-01-09","3":"B.1.36.29","4":"NCR","5":"0","6":"0","7":"3"},{"1":"PH_136","2":"2021-01-08","3":"P.3","4":">3 regions","5":"0","6":"0","7":"459"},{"1":"PH_5","2":"2021-01-08","3":"A.23.1","4":"NCR; Ilocos","5":"0","6":"0","7":"4"},{"1":"PH_98","2":"2021-01-07","3":"R.1","4":"NCR","5":"0","6":"0","7":"3"},{"1":"PH_97","2":"2021-01-05","3":"B.1.1","4":"NCR","5":"0","6":"0","7":"4"},{"1":"PH_66","2":"2021-01-03","3":"B.1.1.7","4":">3 regions","5":"0","6":"0","7":"268"},{"1":"PH_114","2":"2020-12-30","3":"B.1.1.174","4":"NCR","5":"0","6":"0","7":"3"},{"1":"PH_4","2":"2020-12-30","3":"A","4":"NCR; Calabarzon","5":"0","6":"0","7":"3"},{"1":"PH_163","2":"2020-12-28","3":"B.1","4":"NCR","5":"0","6":"0","7":"3"},{"1":"PH_186","2":"2020-12-28","3":"B.1","4":">3 regions","5":"0","6":"0","7":"5"},{"1":"PH_177","2":"2020-12-22","3":"B.1.466.1","4":"Calabarzon; NCR","5":"2","6":"0","7":"27"},{"1":"PH_49","2":"2020-12-10","3":"B.1.1.7","4":"NCR; Calabarzon; Central Visayas","5":"0","6":"0","7":"5"},{"1":"PH_84","2":"2020-12-01","3":"B.1.1","4":"Calabarzon; NCR","5":"0","6":"0","7":"4"},{"1":"PH_31","2":"2020-11-14","3":"B.1.177","4":"Calabarzon; NCR","5":"0","6":"0","7":"4"},{"1":"PH_161","2":"2020-11-09","3":"B.1.441","4":"NCR; Calabarzon; Central Visayas","5":"0","6":"0","7":"7"},{"1":"PH_194","2":"2020-10-30","3":"B.1","4":">3 regions","5":"0","6":"0","7":"23"},{"1":"PH_165","2":"2020-09-17","3":"B.1.36","4":"Calabarzon; NCR; Central Luzon","5":"1","6":"0","7":"11"},{"1":"PH_116","2":"2020-08-05","3":"B.1.1.28","4":">3 regions","5":"4","6":"0","7":"422"},{"1":"PH_79","2":"2020-06-23","3":"B.1.1.63","4":">3 regions","5":"61","6":"0","7":"1337"},{"1":"PH_89","2":"2020-06-16","3":"B.1.1.263","4":">3 regions","5":"15","6":"0","7":"285"},{"1":"PH_182","2":"2020-06-11","3":"B.1","4":"NCR; Western Visayas","5":"0","6":"0","7":"3"},{"1":"PH_160","2":"2020-04-13","3":"B.1.2","4":"NCR; Calabarzon; Central Visayas","5":"0","6":"0","7":"13"},{"1":"PH_8","2":"2020-03-10","3":"B.6","4":">3 regions","5":"3","6":"0","7":"70"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
<strong>Table 3. Number of sequences by cluster identified with the Grapevine-anywhere as of 20 January 2022.</strong> A cluster is defined based on multiple sequences isolated in the Philippines that appeared to descend from the same introductory event on a phylogenetic tree. *Date first identified*, the isolation date of the first identified sequence. *Pango lineage*, the major Pango lineage of the sequences that belong to the same cluster. *New submission*, new sequences submitted from the last report. *Isolated in 4 months*, sequences isolated from 1 October 2021 to 20 January 2022.


$~$
$~$

## SARS-CoV-2 sequencing in the Philippines

$~$


### Total available SARS-CoV-2 sequences in the Philippines: **13191**
### SARS-CoV-2 sequences from GECO project: **698**

$~$

<img src="example_files/figure-html/figure 4-1.png" width="768" style="display: block; margin: auto;" />
<strong>Figure 4. Number of COVID-19 cases and the proportion of sequenced samples in the Philippines.</strong> The gray line indicates the mean cases in a 7 days window based on the JHU data base, whereas the red bars indicate the estimated percentage of sequenced samples among cases in a month. The proportions in January and February, 2020 were discarded as they are outliers.


$~$
$~$

## Epidemiology of COVID-19 in the Philippines

$~$

<img src="example_files/figure-html/figure 5-1.png" width="960" style="display: block; margin: auto;" />
<strong>Figure 5. Mean effective reproductive number (Rt) of COVID-19 in the Philippines by region from December 2021 to January, 2022.</strong> The reproductive number (R) is defined as the number of new infections that one infected patient can cause in a susceptible population. Here, *the mean effective reproductive number* (Rt) was inferred by daily number of cases reported in MOH, Philippines in a window of seven days. The horizontal line indicates one. If Rt is greater than 1, the case number in the region will likely continue to grow. If the Rt is below 1, the new cases may continue to appear at a slower rate. The R values denoted with the region name represent the most recent estimates. More regional epidemiological statistics can be found [here](https://github.com/GECO-PH/GECO-covid/blob/main/supp/region.md).


$~$
$~$


## SARS-CoV-2 mutations of interest

Spike protein

* __69-70Del__ (Alpha, Omicron): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=variant&d=tree&f_country=Philippines&gt=S.69-,70-&onlyPanels&p=full&sidebar=closed)

* __T95I__ (Mu, Omicron): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=gt-S_95&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed)

* __144-__ (Alpha, Eta, Omicron): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=gt-S_144&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed)

* __K417N__ (Beta, Omicron): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=gt-S_417&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed)

* __T478K__ (Delta, Omicron): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=gt-S_478&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed)

* __E484K__ (Beta, Gamma, Eta, Mu): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=gt-S_484&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed)

* __N501Y__ (Alpha, Beta, Gamma, Mu, Omicron): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=gt-S_501&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed)

* __H655Y__ (Gamma, Omicron): [Distribution on the Philippine isolates](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123?c=gt-S_655&d=tree&f_country=Philippines&onlyPanels&p=full&sidebar=closed)

$~$

<body>
<small> 

Relevant functions including antibody escape (S 69-70Δ, S 144, S 417, S 484) and receptor binding (S 417, S 484, S 501). 69-70Del or 69-70Δ, deletions at positions 69-70. 

</small>
</body>


$~$
$~$

## Data sources and references

Data

* [GECO website](https://www.geco-seqlab.org)
* [DOH Data drop](https://drive.google.com/drive/folders/1ZPPcVU4M7T-dtRyUceb0pMAd8ickYf8o)
* [GISAID](http://gisaid.org) ([acknowledgement table](https://github.com/GECO-PH/GECO-covid/tree/main/acknowledgement_table))
* [JHU COVID data](https://coronavirus.jhu.edu)

Methods

* [Analyses in this report](https://github.com/GECO-PH/GECO-covid/blob/main/supp/methods.md)
* [Nextstrain](https://nextstrain.org) ([build](https://nextstrain.org/community/GECO-PH/GECO-covid@main/20220123) for GECO project)
* [Grapevine-anywhere](https://github.com/GECO-PH/grapevine-anywhere)

References

* [WHO](https://www.who.int/en/activities/tracking-SARS-CoV-2-variants/)
* [Pango lineage list](https://cov-lineages.org/lineage_list.html)


### PDF version and previous reports

2021-11 [pdf](https://github.com/GECO-PH/GECO-covid/blob/main/report/2021-November.pdf)

2021-12 [pdf](https://github.com/GECO-PH/GECO-covid/blob/main/report/2021-December.pdf)

2022-01 [pdf](https://github.com/GECO-PH/GECO-covid/blob/main/report/2022-January.pdf)

$~$


<img src="logo.jpg" width="550" style="display: block; margin: auto;" />
