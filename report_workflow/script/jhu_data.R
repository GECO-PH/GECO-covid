suppressWarnings( suppressMessages( library( tidyverse ) ) )
suppressWarnings( suppressMessages( library( zoo ) ) )
suppressWarnings( suppressMessages( library( lubridate ) ) )

suppressWarnings( suppressMessages( library( coronavirus ) ) )

config = yaml::read_yaml("config.yaml")

# raw_RamiKrispin = "https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/coronavirus_2023.csv"


# 1 fetch the data from JHU database ####

    # source code from coronavirus package

# df = readr::read_csv( file      = raw_RamiKrispin,
#                       col_types = readr::cols( date = readr::col_date(format = "%Y-%m-%d"),
#                                                cases = readr::col_number(),
#                                                continent_code = readr::col_character()) )
# 
# df$location      = ifelse( df$province == "" | is.na(df$province), 
#                            df$country, paste(df$province, df$country, sep = ", ") )
# df$location_type = ifelse( df$province== "" | is.na(df$province), 
#                            "country", "state" )
# 
# df$location = gsub( "Korea, South", "South Korea",  df$location )
# df$location = gsub( "Bonaire, Sint Eustatius and Saba",
#                     "Bonaire and Sint Eustatius and Saba",  df$location)
# df$location = gsub( "^\\, ", "",  df$location )
# 
# df$data_type = ifelse( df$type == "confirmed", "cases_new",
#                        ifelse( df$type == "recovery", "recovered_new", "deaths_new") )
# 
# df$value = df$cases
# df$province = df$country = df$type = df$cases = NULL
# 
# col_order = c( "date", "location", "location_type", "data_type","value", "lat", "long")
# df = df[ col_order ]


covid19_df <- refresh_coronavirus_jhu()


data_ph = 
  covid19_df %>%
  filter( location == "Philippines" ) %>% 
  spread( data_type, value ) %>% 
  arrange( date ) %>%                                        
  mutate( deaths = deaths_new, cases = cases_new ) %>%       
  mutate( cases_07 = floor( rollmean(cases, k = 7, fill=NA, align="right") ), 
          deaths_07 = floor( rollmean(deaths, k = 7, fill=NA, align="right") ) ) %>% 
  ungroup() 

data_ph[ is.na(data_ph) ] = 0   


# 2 export as csv ####

output_name = file.path( config$folder_most_recent, 
                         paste0( "case_JHU_PH_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( data_ph, output_name, quote = FALSE, row.names = FALSE )



