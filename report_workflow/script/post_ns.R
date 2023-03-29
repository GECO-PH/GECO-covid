suppressWarnings( suppressMessages( require( yaml ) )) 
suppressWarnings( suppressMessages( require( tidyverse )) ) 
suppressWarnings( suppressMessages( require( seqinr ) ) ) 

config = yaml::read_yaml("config.yaml")


# 1 import the metadata ####

meta = readr::read_tsv( list.files( config$folder_most_recent, pattern = "^metadata_PH", full.names = TRUE ),
                        col_types = paste0( rep("c",27), collapse = "") )


# 2 edit additional info ####

# additional info found in Nextstrain
# for example - (not necessary)
# VUM (variant under monitor) Eta (B.1.525)
# fVUM (former variant under monitor) Theta (P.3)


    # add to variant_PH file if necessary

variant_txt = list.files( config$folder_most_recent, pattern = "variant_PH", full.names = TRUE )

print( paste0( "Previous variant type: ", length( read_lines( variant_txt ) ) ) )
  

meta$Variant[ grep( "GR|GK|GH", meta$Variant ) ] = NA


# info_line1 = "'VUM (variant under monitor) Eta (B.1.525)'"
# info_line2 = "'fVUM (former variant under monitor) Theta (P.3)'"
# info_line  = c( info_line1, info_line2 )
# for( i in 1: length( info_line ) )
# {
#   sys_line = paste( "echo ", info_line[i], " >> ", variant_txt )
#   
#   system( sys_line )
# }

#     # VUM Eta (B.1.525)
# 
# idx_eta = grep( "B\\.1\\.525$", meta$`Pango lineage`)
# 
#     # fVUM theta (P.3)
# 
# idx_theta = grep( "P.3$", meta$`Pango lineage`)
# 
# meta$Variant[ idx_eta ]   = "VUM Eta"
# meta$Variant[ idx_theta ] = "VUM Theta"


# check by ymd(meta$date)

meta$date[ which( meta$date == "0202-07-26" ) ] = "2020-07-26"


# 3 save the edited metadata ####
output_name = file.path( config$folder_most_recent, 
                         paste0( "postNS_metadata_PH_", gsub( "-", "", Sys.Date() ), ".tsv" ) )

readr::write_tsv( meta, output_name, na = "" )


