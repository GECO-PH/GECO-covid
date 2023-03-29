suppressWarnings( suppressMessages( require( yaml ) ) )
suppressWarnings( suppressMessages( require( tidyverse ) ) )
suppressWarnings( suppressMessages( require( lubridate ) ) )

config = yaml::read_yaml("config.yaml")

args = commandArgs( trailingOnly = TRUE )

if ( length(args) !=2 ) { stop( "try - Rscript table.R YYYY-MM-DD YYYY-MM-DD", call. = FALSE ) } 


period_start = args[1]
period_end   = args[2]

# variables in the table 
# 1 cluster - cluster name 
# 2 first_identified - collection date of the first isolate
# 3 cluster_pango - corresponding to the Pango nomenclature
# 3 distribution - areas where the cluster were found
# 4 new_from_last_report - number of sequences __submitted__ since last report
#     4.5 percent_from_last_report - percent of the sequences __submitted__ since last report
# 5 cumulative - cumulative number of sequences
# 6 new_period - number of sequences __isolated__ during a specified period
#     6.5 percent_period - percent of the sequences __isolated__ during a specified period


metadata = readr::read_tsv( list.files( config$folder_most_recent, pattern = "postNS", full.names = TRUE ) )

geo_admin_csv = config$ph_geo_admin_table
geo_admin     = read.csv( geo_admin_csv, header = TRUE )

metadata$division[ which( metadata$division == "Bangsamoro Autonomous Region In Muslim Mindanao" ) ] = 
  "Bangsamoro Autonomous Region in Muslim Mindanao"


# 1_2_3_4 cluster ####

cluster = 
  metadata %>%
  filter( !is.na(cluster)  ) %>%
  #filter( cluster != "PH_"  ) %>%
  group_by( cluster ) %>%
  dplyr::count() %>%
  filter( n >= 5 ) %>% 
  arrange( cluster ) %>%
  pull( cluster )


first_identified = 
  sapply( as.list( cluster ), 
          function(x)
          {
            y  = which( metadata$cluster == x )
            dd = metadata$date[ y ]
            
            dd2 = dd[ grep( "^[0-9]{4}-[0-9]{2}-[0-9]{2}", dd ) ] 
            
            z  = min( ymd( dd2 )  )
            return( as.character(z) )
          })


cluster_pango = 
  sapply( as.list( cluster ), 
          function(x)
          {
            y  = which( metadata$cluster == x )
            
            dd = metadata$pango_lineage[ y ]
            dd = dd[ which( dd != "None" ) ]
            
            tb = as.data.frame( table(dd), stringsAsFactors = FALSE )
            tb = tb[ order( tb$Freq, decreasing = TRUE ), ]
            
            pp = tb[1,1]
            
            return( pp )
          })


cluster_dist = 
  sapply( as.list( cluster ), 
          function(x)
          {
            y  = which( metadata$cluster == x )
            
            dd = metadata$division[ y ]
            dd = dd[ which( dd != "?" ) ]
            
            if( length( dd ) == 0 ){ z = NA }else
            {
              df_d = as.data.frame( table(dd), stringsAsFactors = FALSE )
              df_d = df_d[ order( df_d$Freq, decreasing = TRUE ), ]  
              
              do = df_d$dd
              
              if( length( do ) > 3 ){ z = ">3 regions" }else
              {
                z = paste( geo_admin$working[ match( do, geo_admin$GISAID ) ], collapse = "; ")  
              }
              return( z )
            }  
          })



# 5 New from the last report ####

n_postNS = length( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE ) )
prev_metadata = readr::read_tsv( list.files( config$folder_previous, pattern = "postNS", full.names = TRUE )[n_postNS] )

cluster_current = 
  metadata %>%
  filter( !is.na(cluster)  ) %>%
  filter( cluster != "PH_"  ) %>%
  group_by( cluster ) %>%
  dplyr::count() %>%
  filter( n >= 3 ) %>% 
  arrange( cluster )
  
cluster_new = 
  metadata %>%
  filter( cluster != "PH_"  ) %>%
  filter( ! strain %in% prev_metadata$strain ) %>%
  group_by( cluster ) %>%
  dplyr::count() 
  

m_label = match( cluster, cluster_new$cluster )
.na     = which( is.na( m_label ) )

m_label[ .na ] = 1

new_from_last_report        = cluster_new$n[ m_label ]
new_from_last_report[ .na ] = 0



# 5 Cumulative ####

cum_table = 
  metadata %>%
  select( cluster ) %>%
  group_by( cluster ) %>%
  dplyr::count() 

cumulative = cum_table$n[ match( cluster, cum_table$cluster ) ]


# 6 new in a recent period ####

cluster_period = 
  metadata %>%
  filter( ymd( date ) >= ymd( period_start )  ) %>%
  filter( ymd( date ) <= ymd( period_end ) ) %>%
  filter( !is.na(cluster)  ) %>%
  filter( cluster != "PH_"  ) %>%
  group_by( cluster ) %>%
  dplyr::count() %>%
  arrange( cluster )


m_label2 = match( cluster, cluster_period$cluster )
.na2     = which( is.na( m_label2 ) )

m_label2[ .na2 ] = 1

new_period        = cluster_period$n[ m_label2 ]
new_period[ .na2 ] = 0



# F export the table 

table_out3 = data.frame( cluster, first_identified, cluster_pango,
                         cluster_dist, new_from_last_report, new_period, cumulative )

table_out3 = table_out3[ order( table_out3$new_period, 
                                ymd(table_out3$first_identified), 
                                decreasing = TRUE ), ]

output_name = file.path( config$folder_most_recent, 
                         paste0( "table3_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( table_out3, output_name, quote = FALSE, row.names = FALSE )

