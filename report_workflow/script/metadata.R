suppressWarnings( suppressMessages( require( yaml ) )) 
suppressWarnings( suppressMessages( require( tidyverse )) ) 
suppressWarnings( suppressMessages( require( seqinr ) ) ) 
suppressWarnings( suppressMessages( require( rjson ) ) ) 

config = yaml::read_yaml("config.yaml")

# 0 read in ####


    # 1 metadata_gisaid_PH.tsv
ph_gisaid_meta = readr::read_tsv( file.path( config$folder_most_recent, config$ph_gisaid_metadata ), 
                                  col_types = paste0( rep("c",25), collapse = "") )

    # 2 geo_admin.csv
ph_geo_admin = read.csv( config$ph_geo_admin_table, header = TRUE )

    # 3 redcap_metadata.strain.formatted.csv
redcap_meta = read.csv( paste0( config$folder_most_recent, "/" , config$redcap_metadata ), header = TRUE )

    # 4 redcap_gisaid.lineages.with_all_traits.with_phylotype_traits
grapevine_output = read.csv( paste0( config$folder_most_recent, "/" , config$grapevine_output ), header = TRUE )

    # grapevine_output2 = read.csv( paste0( config$folder_most_recent, "/" , "0204_grapevine_output.csv" ), header = TRUE )

    # 5 redcap_formatted.fasta
redcap_fas = read.fasta( file.path(config$folder_most_recent,config$redcap_fas), forceDNAtolower = FALSE )


    # 6 variant_PH_20XXXXXX
ls_variant_PH    = list.files( config$folder_previous, pattern = "variant_PH_", full.names = TRUE )
variant_previous = read_lines( ls_variant_PH[ length(ls_variant_PH) ] ) 

    # 7 redcap_metadata.csv
redcap_raw = read.csv( paste0( config$folder_most_recent, "/" , config$redcap_rawdata ), header = TRUE )


    # 8 Pango lineage alias 

alias_key = fromJSON( file = paste0( config$folder_most_recent, "/" , config$alias_key ) )

sub_omi_pango = 
  unlist( sapply( alias_key, 
                  function(x){  if( length(x)==1 & TRUE %in% grepl( "B\\.1\\.1\\.529", x ) ){ return(T) }else{ return(F) }  } ) 
          )

sub_omi_pango = names(alias_key)[ sub_omi_pango ]

# 1 edit the division name ####


    # NCR cities
c_ncr = c( "Quezon City", "Pasay City", "Navotas City", "Manila City", "Caloocan City",
           "Taguig City", "Manila")

ph_gisaid_meta$division[ which( ph_gisaid_meta$division %in% c_ncr ) ]     = "National Capital Region"
ph_gisaid_meta$division[ which( ph_gisaid_meta$division == "Davao" ) ]     = "Davao Region"
ph_gisaid_meta$division[ which( ph_gisaid_meta$division == "Zamboanga" ) ] = "Zamboanga Peninsula"
ph_gisaid_meta$division[ grep( "Bicol Region", ph_gisaid_meta$division ) ] = "Bicol"
ph_gisaid_meta$division[ grep( "ARMM", ph_gisaid_meta$division ) ]         = "Bangsamoro Autonomous Region in Muslim Mindanao"


ph_gisaid_meta$division = gsub( " \\(.*\\)$", "", ph_gisaid_meta$division )

ph_gisaid_meta$division[ which( ph_gisaid_meta$division == "Autonomous Region In Muslim Mindanao" ) ] =
  "Bangsamoro Autonomous Region in Muslim Mindanao"


    # change to names following ph_gisaid_meta$GISAID
ph_gisaid_meta$division = unlist( map( ph_gisaid_meta$division, 
                                       function(x)
                                       {
                                         if( ( x %in% ph_geo_admin$GISAID ) | ( x == "?" ) )
                                         {
                                           return( x )
                                         }else
                                         {
                                           if( x %in% ph_geo_admin$short )
                                           {
                                             y = grep( paste0(x, "$") , ph_geo_admin$short, ignore.case = T )
                                             
                                             return( ph_geo_admin$GISAID[y] )
                                           }else
                                           {
                                             return(NA)  
                                           }   
                                         }
                                       } ) )

ph_gisaid_meta$division[ which( ph_gisaid_meta$division == "Bangsamoro Autonomous Region in Muslim Mindanao" ) ] =
  "Bangsamoro Autonomous Region In Muslim Mindanao"


# if any admin. names in the data unsolved? 
print( paste0( "no. of NA in division = ", 
               length( ph_gisaid_meta$division[ is.na(ph_gisaid_meta$division) ] ) ) )

print( paste0( "no. of unique division, including quesion marks = ",
               length( unique( ph_gisaid_meta$division )  )  ) )



# 2 REDCap metadata ####

    # check duplicate

print( paste0( "Is there is duplicated strain name: ", ( TRUE %in% duplicated( redcap_meta$strain ) ) ) )
print( paste0( "No of sequences from REDCap formatted data: ", length(redcap_meta$strain) ) )


gisaid_sim_name   = str_match( ph_gisaid_meta$strain, ".*\\/([A-Z0-9-]+)\\/.*" )[,2]
idx_redcap_unique = which( !redcap_meta$gisaid_name %in% gisaid_sim_name )        # entries not in GISAID

unique_redcap_meta = redcap_meta[ idx_redcap_unique, ]
  
    # division
unique_redcap_meta$adm1 = unlist( map( unique_redcap_meta$adm1,
                                       function(x)
                                       {
                                         if( x == "" ){ return("?") }else
                                         {
                                           y = match( x, ph_geo_admin$redcap ) 
                                           return( ph_geo_admin$GISAID[y] ) 
                                         }
                                       } ) )

unique_redcap_meta$adm1[ which( unique_redcap_meta$adm1 == "Bangsamoro Autonomous Region in Muslim Mindanao" ) ] =
  "Bangsamoro Autonomous Region In Muslim Mindanao"

    # other variables
dummy_df = ph_gisaid_meta[ 1:dim(unique_redcap_meta)[1], ]

dummy_df$strain = NA
dummy_df$strain = gsub( "hCoV-19/", "", unique_redcap_meta$strain )

dummy_df$gisaid_epi_isl = NA
dummy_df$gisaid_epi_isl = paste0( "GECO_", gsub( "-", "_", unique_redcap_meta$central_id ) )

dummy_df$date = NA
dummy_df$date = unique_redcap_meta$date_collected

dummy_df$`Additional location information` = NA

dummy_df$`Sequence length` = NA
dummy_df$`Sequence length` = unlist( map( unique_redcap_meta$sequence_length,
                                          function(x)
                                          {
                                            if( is.na(x) | (! is.numeric(x)) )
                                            {
                                              return( NA )
                                            }else
                                            {
                                              return( as.character(x) )  
                                            } } ) 
                                     )

dummy_df$`Patient age` = NA
dummy_df$`Patient age` = unlist( map( unique_redcap_meta$age,
                                      function(x)
                                      {
                                        if( is.na(x) | (! is.numeric(x)) )
                                        {
                                          return( "unknown" )
                                        }else
                                        {
                                          return( as.character(x) )  
                                        } } ) 
                                 )
dummy_df$Gender = NA
dummy_df$Gender = ifelse( unique_redcap_meta$sex == "", "unknown", unique_redcap_meta$sex )

dummy_df$Clade = NA

dummy_df$pango_lineage = NA
dummy_df$pango_lineage = ifelse( unique_redcap_meta$pango == "", "None", unique_redcap_meta$pango )

# dummy_df$`Pangolin version` = NA
# dummy_df$`Pangolin version` = ifelse( unique_redcap_meta$pango_version == "", NA, 
#                                       unique_redcap_meta$pango_version )

dummy_df$Variant = NA
dummy_df$`AA Substitutions` = NA
dummy_df$`Submission date` = NA
dummy_df$`Is reference?` = NA
dummy_df$`Is low coverage?` = NA
dummy_df$`Is complete?` = NA
dummy_df$`N-Content` = NA
dummy_df$`GC-Content` = NA

dummy_df$division = unique_redcap_meta$adm1
dummy_df$location = "?"


# *2.5 Supplement with grapevine output ####

lack_lineage = dummy_df$strain[ which( dummy_df$pango_lineage == "None" ) ]

n_before_supp = length( lack_lineage )

for( i in lack_lineage )
{
  m = match( i, gsub( "hCoV-19\\/", "", grapevine_output$strain ) )
  
  if( is.na(m) )
  {
    next()
  }else
  {
    if( grapevine_output$lineage[m] != "" )
    {
      d = which( dummy_df$strain == i )
      
      dummy_df$pango_lineage[d] = grapevine_output$lineage[m]
    }
  }
}

n_post_supp = length( dummy_df$strain[ which( dummy_df$pango_lineage == "None" ) ] )

print( "pango assignation was based on the GISAID, but" )
print( paste0(  (n_before_supp- n_post_supp), " has been supplemented by output of grapevine" ) )





# 3 REDCap fasta ####

redcap_seq_name = attributes( redcap_fas )$names
redcap_seq      = getSequence( redcap_fas )

redcap_seq_name = gsub( "^hCoV-19/", "", redcap_seq_name )

idx_dummy = which( redcap_seq_name %in% dummy_df$strain )        # entries in dummy_df

    # export fasta 

output_fas_name = paste0( config$folder_most_recent, "/",
                          "redcap_only_", gsub( "-", "", Sys.Date() ), ".fasta" )

write.fasta( redcap_seq[ idx_dummy ], redcap_seq_name[ idx_dummy ], output_fas_name )



# 4 combine metadata ####

out_ph_meta = rbind( ph_gisaid_meta, dummy_df )


# * 4.1 Variant ####

variant_found = unique(ph_gisaid_meta$Variant)
variant_found = variant_found[ ! is.na( variant_found ) ]



variant_found = unique( c( variant_previous, variant_found ) )

    # manual review -
    # remove GH/490R (B.1.640)
    # remove - 5 Mu (B.1.621, B.1.621.1, BB.1, BB.2)
    # edit VOI Eta 
    # edit Eta (VUM), P.3 (fVUM)
    # etit Eta (fVUM)

variant_found = variant_found[ seq(1,7) ]

write_lines( variant_found, 
             file.path( config$folder_most_recent, 
             paste0( "variant_PH_", gsub( "-", "", Sys.Date() ), ".txt" ) ) ) 

print( "Current VOC-" )
print( variant_found )


    # alpha - "VOC Alpha GRY (B.1.1.7+Q.*) first detected in the UK"

idx_alpha = grep( "B\\.1\\.1\\.7$|Q\\.[123456789]$", out_ph_meta$pango_lineage )
idx_alpha = unique( c( idx_alpha, grep( "Alpha", out_ph_meta$Variant ) ) )

    # beta - "VOC Beta GH/501Y.V2 (B.1.351+B.1.351.2+B.1.351.3) first detected in South Africa"

idx_beta = grep( "B\\.1\\.351$|B\\.1\\.351\\.[0-9]$", out_ph_meta$pango_lineage )
idx_beta = unique(  c( idx_beta, grep( "Beta", out_ph_meta$Variant ) ) )

    # VOC Gamma GR/501Y.V3 (P.1+P.1.*) first detected in Brazil/Japan

idx_gamma = grep( "P\\.1$|P\\.1\\..*", out_ph_meta$pango_lineage )

    # VOC Delta GK (B.1.617.2+AY.*) first detected in India

idx_delta = grep( "B\\.1\\.617\\.2$|AY\\..*$", out_ph_meta$pango_lineage )
idx_delta = unique( c( idx_delta, grep( "Delta", out_ph_meta$Variant ) ) ) 

    # (f)VUM Theta GR/1092K.V1 (P.3) first detected in the Philippines

idx_theta = grep( "P.3$", out_ph_meta$pango_lineage )
idx_theta = unique( c( idx_theta, grep( "Theta", out_ph_meta$Variant ) ) ) 

    # (f)VUM Eta G/484K.V3 (B.1.525) first detected in UK/Nigeria

idx_eta = grep( "B\\.1\\.525$", out_ph_meta$pango_lineage )

    
    # VOC Omicron GRA (B.1.1.529+BA.*) first detected in Botswana/Hong Kong/South Africa

str_omi = paste0( "B\\.1\\.1\\.529$|", paste( sub_omi_pango, collapse = "\\.|" ), "\\." )

idx_omi = grep( str_omi, out_ph_meta$pango_lineage )
idx_omi = c( idx_omi, 
             which( out_ph_meta$Variant == "VOC Omicron GRA (B.1.1.529+BA.*) first detected in Botswana/Hong Kong/South Africa" )  )

idx_omi = unique( idx_omi )
    
    # removed
    # VUM GH/490R B.1.640
    # idx_B.1.640 = grep( "B\\.1\\.640$|B\\.1\\.640\\.[0-9]$", out_ph_meta$pango_lineage ) 
    # out_ph_meta$Variant[ idx_B.1.640 ] = "VUM B.1.640"
    # mu - VOI Mu GH (B.1.621+B.1.621.1) first detected in Colombia
    # idx_mu = grep( "B\\.1\\.621|B\\.1\\.621\\.1", out_ph_meta$`Pango lineage` )


out_ph_meta$Variant[ idx_alpha ]  = "VOC Alpha"
out_ph_meta$Variant[ idx_beta ]   = "VOC Beta"
out_ph_meta$Variant[ idx_gamma ]  = "VOC Gamma"
out_ph_meta$Variant[ idx_delta ]  = "VOC Delta"
out_ph_meta$Variant[ idx_eta ]    = "VUM Eta"
out_ph_meta$Variant[ idx_theta ]  = "VUM Theta"
out_ph_meta$Variant[ idx_omi ]    = "VOC Omicron"



# * 4.2 PH_Cluster ####

out_sim_name      = paste0( "hCoV-19/",  out_ph_meta$strain )
idx_out_in_redcap = which( out_sim_name %in% grapevine_output$strain )        # entries also in redcap
m_out_redcap      = match( out_sim_name[ idx_out_in_redcap ], grapevine_output$strain )

out_cluster = grapevine_output$ph_cluster[ m_out_redcap ]
out_cluster = gsub( "^ph", "", out_cluster )
out_cluster = paste0( "PH_", out_cluster )

out_ph_meta$cluster = NA
out_ph_meta$cluster[ idx_out_in_redcap ] = out_cluster

out_ph_meta$cluster[ which( out_ph_meta$cluster == "PH_" ) ] = NA


# * 4.3 data source ####

out_short_name    = sapply( stringr::str_split( out_ph_meta$strain, "/" ), function(x) x[2] )
idx_out_in_redcap = which( out_short_name %in% redcap_raw$gisaid_name )        # entries also in redcap

out_ph_meta$source = "GISAID"
out_ph_meta$source[ idx_out_in_redcap ] = "GECO"



# 5 export metadata
output_name = file.path( config$folder_most_recent, 
                         paste0( "metadata_PH_", gsub( "-", "", Sys.Date() ), ".tsv" ) )
  
readr::write_tsv( out_ph_meta, output_name, na = "" )
