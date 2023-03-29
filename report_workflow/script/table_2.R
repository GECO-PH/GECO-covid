suppressWarnings( suppressMessages( require( yaml ) ) )
suppressWarnings( suppressMessages( require( tidyverse ) ) )
suppressWarnings( suppressMessages( require( lubridate ) ) )

config = yaml::read_yaml("config.yaml")


args = commandArgs( trailingOnly = TRUE )

if ( length(args) !=2 ) { stop( "try - Rscript table.R YYYY-MM-DD YYYY-MM-DD", call. = FALSE ) } 


period_start = args[1]
period_end   = args[2]

# variables in the table 
# 1 region_ph - Regions of the Philippines
# 2 new_from_last_report - number of sequences __submitted__ since last report
#     2.5 percent_from_last_report - percent of the sequences __submitted__ since last report
# 3 dominant_variant_period - dominant variant during a specified period
#     3.5 percent_dominant_variant_period - dominant percent during a specified period
# 4 cumulative - cumulative number of sequences
# 5 new_period - number of sequences __isolated__ during a specified period
#    5.5 percent_period - percent of the sequences __isolated__ during a specified period



geo_admin_csv = config$ph_geo_admin_table
geo_admin     = read.csv( geo_admin_csv, header = TRUE )

metadata = readr::read_tsv( list.files( config$folder_most_recent, pattern = "postNS", full.names = TRUE ) )


# 1 region_ph ####

region_ph_df = geo_admin[ order( geo_admin$working_no ), ]

region_ph_df$GISAID[ which( region_ph_df$GISAID == "Bangsamoro Autonomous Region in Muslim Mindanao" ) ] = 
  "Bangsamoro Autonomous Region In Muslim Mindanao"

region_ph = region_ph_df$working



# 2 New from the last report #### 

n_postNS = length( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE ) )
prev_metadata = readr::read_tsv( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE )[n_postNS] )

division_current = 
  metadata %>%
  group_by( division ) %>%
  filter( division != "?" ) %>%
  dplyr::count()

division_new = 
  metadata %>%
  filter( ! strain %in% prev_metadata$strain ) %>%
  group_by( division ) %>%
  filter( division != "?" ) %>%
  dplyr::count() 

total_bet_reports = nrow( metadata ) - nrow( prev_metadata )

m_label = match( region_ph_df$GISAID, division_new$division )
.na     = which( is.na( m_label ) )

m_label[ .na ] = 1

new_from_last_report        = division_new$n[ m_label ]
new_from_last_report[ .na ] = 0

percent_from_last_report = round( new_from_last_report/total_bet_reports*100, 1 )

not_0 = which( percent_from_last_report == 0 )

new_from_last_report = paste0( new_from_last_report, " (", percent_from_last_report, ")"  )
new_from_last_report[ not_0 ] = 0



# 3 dominant_variant_period ####

division_variant = 
  metadata %>%
  filter( ymd( date ) >= ymd( period_start )  ) %>%
  filter( ymd( date ) <= ymd( period_end ) ) %>% 
  group_by( division, pango_lineage ) %>%
  dplyr::count() %>%
  ungroup() %>%
  group_by( division ) %>%
  mutate( prop = (n / sum(n))  )

dominant_variant =
  division_variant %>%
  filter( pango_lineage != "None" ) %>%
  group_by( division ) %>%
  filter( prop == max( prop ) )


if( TRUE %in% duplicated(dominant_variant$division ) )
{
  dup_row = duplicated(dominant_variant$division )
  
  dominant_variant = dominant_variant[which(!dup_row), ]
}


#dominant_variant$var_name = str_match( dominant_variant$Variant, "[A-Za-z]+ ([A-Za-z]+)" )[,2]
dominant_variant_period = dominant_variant$pango_lineage[ match( region_ph_df$GISAID, dominant_variant$division ) ]

percent_dominant_variant_period = dominant_variant$prop[ match( region_ph_df$GISAID, dominant_variant$division ) ]
percent_dominant_variant_period = round( percent_dominant_variant_period*100, 1 )

dominant_variant_period = paste0( dominant_variant_period, " (", percent_dominant_variant_period, ")" ) 

if( "NA (NA)" %in% dominant_variant_period ){ dominant_variant_period[ dominant_variant_period == "NA (NA)" ] = "-" }


# 4 Cumulative ####

cum_table = 
  metadata %>%
  filter( division != "?" ) %>%
  group_by( division ) %>%
  dplyr::count() 


cumulative = cum_table$n[ match( region_ph_df$GISAID, cum_table$division ) ]



# 5 Percent in a recent period ####

total_period = 
  metadata %>%
  filter( ymd( date ) >= ymd( period_start )  ) %>%
  filter( ymd( date ) <= ymd( period_end ) ) %>%
  nrow()

variant_period = 
  metadata %>%
  filter( ymd( date ) >= ymd( period_start )  ) %>%
  filter( ymd( date ) <= ymd( period_end ) ) %>%
  group_by( division ) %>%
  dplyr::count() 


m_label2 = match( region_ph_df$GISAID, variant_period$division )
.na2     = which( is.na( m_label2 ) )

m_label2[ .na2 ] = 1

new_period        = variant_period$n[ m_label2 ]
new_period[ .na2 ] = 0

percent_period = round( new_period/total_period*100, 1 )

not_0 = which( percent_period == 0 )

new_period = paste0( new_period, " (", percent_period, ")"  )
new_period[ not_0 ] = 0



# F export the table 

table_out2 = data.frame( region_ph, new_from_last_report, dominant_variant_period, new_period,
                        cumulative )



output_name = file.path( config$folder_most_recent, 
                         paste0( "table2_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( table_out2, output_name, quote = FALSE, row.names = FALSE )







