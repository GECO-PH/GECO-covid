suppressWarnings( suppressMessages( require( yaml ) ) )
suppressWarnings( suppressMessages( require( tidyverse ) ) )
suppressWarnings( suppressMessages( require( lubridate ) ) )

config = yaml::read_yaml("config.yaml")


args = commandArgs( trailingOnly = TRUE )

if ( length(args) !=2 ) { stop( "try - Rscript table.R YYYY-MM-DD YYYY-MM-DD", call. = FALSE ) } 


period_start = args[1]
period_end   = args[2]

# variables in the table 
# 1 pango_lineage - pango monenclature
# 2 new_from_last_report - number of sequences __submitted__ since last report
#     2.5 percent_from_last_report - percent of the sequences __submitted__ since last report
# 3 cumulative - cumulative number of sequences
# 4 new_period - number of sequences __isolated__ during a specified period
#     4.5 percent_period - percent of the sequences __isolated__ during a specified period


metadata = readr::read_tsv( list.files( config$folder_most_recent, pattern = "postNS", full.names = TRUE ) )


# Target lineages 
# BA.1
# BA.2.12.1
# BA.2.75
# The other BA.2
# BA.4
# BA.5 

# dominant BA.2 - BA.2.3 

metadata$omicron = NA

# ba.1
metadata$omicron[ grep( "BA.1", metadata$pango_lineage ) ] = "BA.1.*"
# ba.2
metadata$omicron[ grep( "BA\\.2$", metadata$pango_lineage ) ]          = "BA.2"
metadata$omicron[ grep( "BA\\.2\\.3$", metadata$pango_lineage ) ]      = "BA.2.3"
metadata$omicron[ grep( "BA\\.2\\.3\\.20|CM", metadata$pango_lineage ) ]  = "BA.2.3.20.*"
metadata$omicron[ grep( "BA\\.2\\.12\\.1$", metadata$pango_lineage ) ] = "BA.2.12.1"
metadata$omicron[ grep( "BA\\.2\\.75", metadata$pango_lineage ) ]      = "BA.2.75.*"
metadata$omicron[ intersect( grep("BA\\.2", metadata$pango_lineage ), which( is.na(metadata$omicron) ) ) ] = "Other BA.2.*"
# ba.4
metadata$omicron[ grep( "BA\\.4", metadata$pango_lineage ) ] = "BA.4.*"
# ba.5
metadata$omicron[ grep( "BA\\.5$", metadata$pango_lineage ) ]     = "BA.5"
metadata$omicron[ grep( "BA\\.5\\.2", metadata$pango_lineage ) ]  = "BA.5.2.*"
metadata$omicron[ intersect( grep("BA\\.5", metadata$pango_lineage ), which( is.na(metadata$omicron) ) ) ] = "Other BA.5.*"

metadata$omicron[ grep( "BE\\.1", metadata$pango_lineage ) ] = "BE.1.*"
metadata$omicron[ grep( "BQ\\.1", metadata$pango_lineage ) ] = "BQ.1.*"

# recombination 
metadata$omicron[ grep( "XBB", metadata$pango_lineage ) ] = "XBB.*"
metadata$omicron[ grep( "XBC", metadata$pango_lineage ) ] = "XBC.*"


# Pango lineage

pango_lineage = c( "BA.1.*", 
                   "BA.2", "BA.2.3", "BA.2.3.20.*", "BA.2.12.1", "BA.2.75.*", "Other BA.2.*", 
                   "BA.4.*", 
                   "BA.5", "BA.5.2.*", "Other BA.5.*",
                   "BE.1.*", "BQ.1.*",
                   "XBB.*", "XBC.*" )




# 4 New from the last report ####

n_postNS = length( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE ) )
prev_metadata = readr::read_tsv( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE )[n_postNS] )

variant_current = 
  metadata %>%
  group_by( omicron ) %>%
  dplyr::count() 

variant_new = 
  metadata %>%
  filter( ! strain %in% prev_metadata$strain ) %>% 
  group_by( omicron ) %>%
  dplyr::count() 
  

total_bet_reports = nrow( metadata ) - nrow( prev_metadata )

m_label = match( pango_lineage, variant_new$omicron )
.na     = which( is.na( m_label ) )

m_label[ .na ] = 1

new_from_last_report        = variant_new$n[ m_label ]
new_from_last_report[ .na ] = 0

percent_from_last_report = round( new_from_last_report/total_bet_reports*100, 1 )

not_0 = which( percent_from_last_report == 0 )

new_from_last_report = paste0( new_from_last_report, " (", percent_from_last_report, ")"  )
new_from_last_report[ not_0 ] = 0




# 5 Cumulative ####

cum_table = 
  metadata %>%
  select( omicron ) %>%
  group_by( omicron ) %>%
  dplyr::count() 

cumulative = cum_table$n[ match( pango_lineage, cum_table$omicron ) ]

cumulative[ is.na( cumulative ) ] = 0


# 6 Percent in a recent period ####

total_period = 
  metadata %>%
  filter( ymd( date ) >= ymd( period_start )  ) %>%
  filter( ymd( date ) <= ymd( period_end ) ) %>%
  nrow()

variant_period = 
  metadata %>%
  filter( ymd( date ) >= ymd( period_start )  ) %>%
  filter( ymd( date ) <= ymd( period_end ) ) %>%
  group_by( omicron ) %>%
  dplyr::count() 

m_label2 = match( pango_lineage, variant_period$omicron )
.na2     = which( is.na( m_label2 ) )

m_label2[ .na2 ] = 1

new_period        = variant_period$n[ m_label2 ]
new_period[ .na2 ] = 0

percent_period = round( new_period/total_period*100, 1 )

not_0 = which( percent_period == 0 )

new_period = paste0( new_period, " (", percent_period, ")"  )
new_period[ not_0 ] = 0



# export the table 

table_out = data.frame( pango_lineage,
                        new_from_last_report, new_period, cumulative )

output_name = file.path( config$folder_most_recent, 
                         paste0( "table_omicron_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( table_out, output_name, quote = FALSE, row.names = FALSE )


