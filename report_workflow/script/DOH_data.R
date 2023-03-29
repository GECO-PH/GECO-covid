suppressWarnings( suppressMessages( library( tidyverse ) ) )
suppressWarnings( suppressMessages( library( lubridate ) ) )
suppressWarnings( suppressMessages( library( zoo ) ) )

config = yaml::read_yaml("config.yaml")


# 0 trimming the raw data #### 

    # remove space in the file names
    # be careful of commas in the last column

download_site = "../ph_data/most_recent/"
csv_files = list.files( download_site, "Information", full.names = TRUE )

for( f in 1:length(csv_files) )
{
  cml = paste0( "cut -d ',' -f1,6,7,12,13,14 ", csv_files[f], " > ", download_site,
                "DOH_batch_", f, ".csv" )
  system( cml )
}


# 1 importing the data ####

dir = file.path( config$folder_most_recent, config$doh_case_info )

raw_input = 
  lapply( as.list(dir),
          function(x)
          {
            y = read.csv( x, stringsAsFactors = FALSE )
            return(y)
          } )
raw_input  = do.call( rbind, raw_input )
raw_input0 = tibble( raw_input )


# 2 primary cleaning ####

raw_input = 
  raw_input0 %>% 
  filter( DateRepConf != "" ) %>%
  filter( RegionRes != "" ) %>%
  filter( RegionRes != "ROF" )      # ROF = Returning Overseas Filipino

raw_data = 
  as_tibble( 
    raw_input  %>%
      transmute( date   = ymd( DateRepConf ),      # date = DateRepConf
                 region = RegionRes ) ) %>%        # region = 17 regions in PH
  arrange( date )

raw_data = 
  raw_data %>% 
  dplyr::group_by( date, region ) %>%
  dplyr::count()

names(raw_data)[3] = "cases"


    # fix the names of region 

geo_admin_csv = config$ph_geo_admin_table
geo_admin     = read.csv( geo_admin_csv, header = TRUE )

raw_data$region = unlist( map( raw_data$region, 
                               function(x)
                               {
                                 y = gsub( ":.*$", "", x )
                                 z = grep( paste0(y, "$"), geo_admin$short, ignore.case = TRUE )
                                 
                                 if( length(z) == 0 )
                                 {
                                   z = grep( y, geo_admin$long, ignore.case = TRUE )
                                 }
                                 
                                 return( geo_admin$working[z] )
                               } ) )

pop_region = data.frame( region = geo_admin$working, pop = geo_admin$population )



# 3 time series - day ####

last.date  = max( raw_data$date ) 
last.dates = last.date - 0:as.numeric( last.date - min(raw_data$date)  )      

data.daily = 
  tibble(
    date     = rep( last.dates, length( unique( raw_data$region ) ) ),
    region   = rep( unique( raw_data$region ), each = length( last.dates ) )      
    ) 

data.daily = left_join( data.daily, raw_data, by = c( "region", "date" ) )     
data.daily = left_join( data.daily, pop_region, by="region")      


    # checks the df

print( paste0( "Each day has 17 entries ? ", sum(table(data.daily$date) == 17) == length(last.dates) ) )

data.daily[ is.na(data.daily) ] = 0


    # 7 day average number and cumulative cases

t = tibble()

for( d in unique( data.daily$region ) ) {
  
  temp = 
    data.daily %>% 
    filter( region == d ) %>% 
    arrange( date ) %>% 
    mutate( cum_cases = cumsum( cases ),      # Cumulative data
            cases_07  = floor( rollmean( cases, k = 7, fill = NA, align="right" ) ) ) %>%
    mutate( cases_100k_07 = round( ( cases_07/pop )*100000, 2 ) ) 
  
  temp[is.na(temp)] = 0
  
  t = rbind(t, temp)
}

data.daily = t
data.daily = data.daily %>% filter( date < max(data.daily$date) )

    # export csv

output_name = file.path( config$folder_most_recent, 
                         paste0( "case_daily_region_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( data.daily, output_name, quote = FALSE, row.names = FALSE )
