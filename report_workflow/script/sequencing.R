suppressWarnings( suppressMessages( library( tidyverse ) ) )
suppressWarnings( suppressMessages( library( zoo ) ) )
suppressWarnings( suppressMessages( library( lubridate ) ) )

config = yaml::read_yaml("config.yaml")


# 1 import the metadata and jhu data ####

jhu_ph = read.csv( list.files( config$folder_most_recent, 
                               pattern = "case_JHU_PH", full.names = TRUE ),
                   header = TRUE )


metadata_ph =  readr::read_tsv( list.files( config$folder_most_recent, 
                                            pattern = "postNS_metadata_PH", full.names = TRUE ) )

metadata_ph$date_type = "Y"
metadata_ph$date_type[ grepl( "[0-9]{4}-[0-9]{2}-[0-9]{2}", metadata_ph$date ) ] = "D"
metadata_ph$date_type[ grepl( "[0-9]{4}-[0-9]{2}[-]{0,1}$", metadata_ph$date ) ] = "M"



# 2 transform to monthly data ####

    # JHU

jhu_ph$year_month = paste0( year(jhu_ph$date), "_", month(jhu_ph$date) )

jhu_monthly_idx = 
  jhu_ph %>% 
  select( year_month, date ) %>% 
  group_by( year_month ) %>% 
  dplyr::summarise( date = min(date) )

jhu_monthly_idx$date[1] = "2020-01-01"


jhu_monthly = 
  jhu_ph %>% 
  group_by( year_month ) %>% 
  dplyr::summarise( cases = sum(cases) ) %>% 
  ungroup()
  

    # combined metadata

# metadata_ph$date[ which( metadata_ph$date_type == "M" ) ] = 
#   paste0( metadata_ph$date[ which( metadata_ph$date_type == "M" ) ], "-15" )

meta_daily = 
  metadata_ph %>% 
  filter( date_type == "D" ) %>%
  group_by( date ) %>%
  dplyr::count() %>%
  dplyr::rename( "no" = "n" )

meta_daily$year_month = paste0( year( meta_daily$date ), "_", month( meta_daily$date ) )

meta_monthly = 
  meta_daily %>%
  group_by( year_month ) %>% 
  dplyr::summarise( no = sum(no) ) %>% 
  ungroup()
  
joined_meta = left_join( meta_monthly, jhu_monthly, by = "year_month" )
joined_meta = left_join( joined_meta, jhu_monthly_idx, by = "year_month" )

joined_meta$prop = (joined_meta$no / joined_meta$cases) *100


    # export the data

output_name = file.path( config$folder_most_recent, 
                         paste0( "sequencing_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( joined_meta, output_name, quote = FALSE, row.names = FALSE )






  