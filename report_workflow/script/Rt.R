suppressWarnings( suppressMessages( library( EpiEstim ) ) )
suppressWarnings( suppressMessages( library( tidyverse ) ) )
suppressWarnings( suppressMessages( library( lubridate ) ) )

config = yaml::read_yaml("config.yaml")


# 1 importing the data ####

case_region_daily = read.csv( list.files( config$folder_most_recent, 
                                          pattern = "case_daily_region", full.names = TRUE ),
                              header = TRUE )



# 2 set the serial interval distribution ####

si_dist = dgamma(0:30, shape = 2.3669, scale = 2.7463) / sum( dgamma(0:30, shape = 2.3669, scale = 2.7463) )

window  = 6
nday    = length( unique(case_region_daily$date) )
t_start = seq( 2, nday - window ) 
t_end   = t_start + window 


# 3 Rt for each region ####

r_regions = tibble()

for( region_n in unique( case_region_daily$region ) ) {
  
  print( region_n )
  
  dat = case_region_daily %>% filter( region == region_n )  
  
  Rs.weekly = estimate_R( dat$cases_07, 
                          method ="non_parametric_si",
                          config = make_config( list( si_distr = si_dist, 
                                                      t_start  = t_start, 
                                                      t_end    = t_end ) ) )
  temp = Rs.weekly$R %>% select( mean     = "Mean(R)",
                                 median   = "Median(R)",
                                 sd       = "Std(R)",
                                 lower_CI = "Quantile.0.025(R)",
                                 upper_CI = "Quantile.0.975(R)")
  
  temp$region           = region_n
  temp$date             = dat$date[ t_end ]
  temp                  = temp %>% filter( mean > 0 )
  temp$latest_R         = round( temp$mean[ nrow(temp) ], 2 )
  temp$region_current   = paste0( region_n, " (R = ", temp$latest_R, ")" )
  
  # Bind the information about each district into the tibble
  r_regions <- rbind( r_regions, temp ) 
}


    # export the csv 

output_name = file.path( config$folder_most_recent, 
                         paste0( "R_region_", gsub( "-", "", Sys.Date() ), ".csv" ) )

write.csv( r_regions, output_name, quote = FALSE, row.names = FALSE )




