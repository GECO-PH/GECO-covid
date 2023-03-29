suppressWarnings( suppressMessages( require( yaml ) ) )
suppressWarnings( suppressMessages( require( tidyverse ) ) )
suppressWarnings( suppressMessages( require( lubridate ) ) )

config = yaml::read_yaml("config.yaml")


args = commandArgs( trailingOnly = TRUE )

if ( length(args) !=2 ) { stop( "try - Rscript table.R YYYY-MM-DD YYYY-MM-DD", call. = FALSE ) } 


period_start = args[1]
period_end   = args[2]

# variables in the table 
# 1 who_label - WHO label of the variant 
# 2 pango_lineage - pango monenclature
# 3 classification - WHO classification
# 4 new_from_last_report - number of sequences __submitted__ since last report
#     4.5 percent_from_last_report - percent of the sequences __submitted__ since last report
# 5 cumulative - cumulative number of sequences
# 6 new_period - number of sequences __isolated__ during a specified period
#     6.5 percent_period - percent of the sequences __isolated__ during a specified period

# resource
# https://www.who.int/en/activities/tracking-SARS-CoV-2-variants/
# https://cov-lineages.org/lineage_list.html


metadata = readr::read_tsv( list.files( config$folder_most_recent, pattern = "postNS", full.names = TRUE ) )


# 1_2_3 WHO label & classification ####

df_variant = unique( metadata$Variant )
df_variant = df_variant[ !is.na(df_variant) ]

   
    # order 

df_variant = sort( df_variant )

who_label      = str_match( df_variant, "([A-Za-z]+) ([A-Za-z]+)" )[ ,3]

    #who_label[6] = "B.1.640"

classification = str_match( df_variant, "([A-Za-z]+) ([A-Za-z]+)" )[ ,2]


    # Pango lineage

variant_log = read_lines( list.files( config$folder_most_recent, pattern = "variant", full.names = TRUE ) )

print( variant_log )

pango_lineage = c( "B.1.1.7/Q.x", "B.1.351", "B.1.617.2/AY.x", "P.1", "B.1.1.529/BA.x", 
                  # "B.1.640", # 2022 Feb - no more B.1.640
                   "B.1.525", "P.3" )



# 4 New from the last report ####

n_postNS = length( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE ) )
prev_metadata = readr::read_tsv( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE )[n_postNS] )

variant_current = 
  metadata %>%
  group_by( Variant ) %>%
  dplyr::count() %>%
  mutate( label = str_match( Variant, "[A-Za-z]+ ([0-9A-Za-z\\.]+)" )[,2] )

variant_new = 
  metadata %>%
  filter( ! strain %in% prev_metadata$strain ) %>% 
  group_by( Variant ) %>%
  dplyr::count() %>%
  mutate( label = str_match( Variant, "[A-Za-z]+ ([0-9A-Za-z\\.]+)" )[,2] )


total_bet_reports = nrow( metadata ) - nrow( prev_metadata )

m_label = match( who_label, variant_new$label )
.na     = which( is.na( m_label ) )

m_label[ .na ] = 1

new_from_last_report        = variant_new$n[ m_label ]
new_from_last_report[ .na ] = 0

percent_from_last_report = round( new_from_last_report/total_bet_reports*100, 1 )

not_0 = which( percent_from_last_report == 0 )

new_from_last_report = paste0( new_from_last_report, " (", percent_from_last_report, ")"  )
new_from_last_report[ not_0 ] = 0


    # *4.1 log new sequence names ####

new_idx    = which( !metadata$strain %in% prev_metadata$strain )
new_strain = metadata$strain[ new_idx ]
write_lines( new_strain, paste0( config$folder_most_recent, "/new_strains_", 
                                 gsub( "-", "", Sys.Date() ), ".txt" ) )



# 5 Cumulative ####

cum_table = 
  metadata %>%
  select( Variant ) %>%
  group_by( Variant ) %>%
  dplyr::count() %>%
  mutate( label = str_match( Variant, "[A-Za-z]+ ([0-9A-Za-z\\.]+)" )[,2] )


cumulative = cum_table$n[ match( who_label, cum_table$label ) ]


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
  group_by( Variant ) %>%
  dplyr::count() %>%
  mutate( label = str_match( Variant, "[A-Za-z]+ ([0-9A-Za-z\\.]+)" )[,2] )


m_label2 = match( who_label, variant_period$label )
.na2     = which( is.na( m_label2 ) )

m_label2[ .na2 ] = 1

new_period        = variant_period$n[ m_label2 ]
new_period[ .na2 ] = 0

percent_period = round( new_period/total_period*100, 1 )

not_0 = which( percent_period == 0 )

new_period = paste0( new_period, " (", percent_period, ")"  )
new_period[ not_0 ] = 0



# F export the table 

table_out = data.frame( who_label, pango_lineage, classification,
                        new_from_last_report, new_period, cumulative )



output_name = file.path( config$folder_most_recent, 
                         paste0( "table1_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( table_out, output_name, quote = FALSE, row.names = FALSE )

