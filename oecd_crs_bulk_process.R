## Reading in raw data from OECD CRS site, writing as full raw dataset. 
# Updating through 2020 for second IMF Deliverable.
# Author: Bryan Burgess
# Created: 2022-12-01
# Updated: 2022-12-01

## CRS Bulk source link: https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=CRS1
# CRS last updated 2022-10-25
# Links last accessed 2022-10-29. If the links don't work, either update or 
# download the zips manually from the OECD CRS Bulk download site.

# Packages --------------------------------------------------------------------
library(rvest)
library(tidyverse)
library(stringi)

options(scipen = 999, timeout = 180)

`%notin%` <- Negate(`%in%`)

# Reading in HTML ---------------------------------------------------------
# Kudos to https://uc-r.github.io/scraping_HTML_text for guidance here

oecd_html <- rvest::read_html("https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=CRS1")

script_text <- oecd_html %>%
  rvest::html_nodes("script") %>%
  rvest::html_text() %>%
  tibble()

file_ids <- unlist(sapply(strsplit(as.character(script_text$.), split = "'"),
                                 function(i){
                                   x <- i[ grepl("./FileView", i)]
                                   if(length(x) == 0) x <- NA
                                   x
                                 }))

(file_ids)
file_ids <- file_ids[!is.na(file_ids)]
file_ids <- stringi::stri_sub(file_ids, 2)


# Create timestamp name variable -----------------------------------------------
oecd_tds <- oecd_html %>%
  rvest::html_nodes("td") %>%
  rvest::html_text()

# Pulling the date each file was last updated.
### NOTE: Varies by file, does not seem that they all update at once, how to 
# handle variation? 

update_ymd <- str_extract_all(oecd_tds, "\\d+/\\d+/\\d+", simplify = TRUE)

(update_ymd)
update_ymd <- update_ymd[update_ymd != ""]

# There is probably a safer way to bind filenames, update titles, and file ids 
# than by location in a vector, but it'll have to do for now. 

zip_file_names <- oecd_tds[str_detect(oecd_tds, "zip$")]
txt_file_names <- str_replace_all(zip_file_names, "zip", "txt")


# Create File -------------------------------------------------------------


# Read in Data ------------------------------------------------------------

#### ADD LOOOP 




# Tried to source this whole doc, OECD's bulk download site seemed to freeze.
# If that happens, wait a minute or two and re-run downloads individually. 

# Saving data in raw bulk data folder, within a general "data" folder. Generic 
# folder location, user must add this directory in whatever directory they
# choose to work in. 
setwd("./data/raw_oecd_bulk_data/")

### Excluded 2014, 2015, and 2016 from the study due to Scope of Work Limitations 
# # 2014
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=a990e786-6647-4e5a-8795-bbec445294ba", 
#               "CRS 2014 Data.zip", quiet = FALSE) 
# crs_14_raw <- read_delim(unz("CRS 2014 Data.zip", "CRS 2014 data.txt"), 
#                          delim = "|", guess_max = 250000)
# 
# 
# # 2015
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=4440e8de-f471-479a-9692-ddd7bf06d7d2", 
#              "CRS 2015 Data.zip", quiet = FALSE) 
# crs_15_raw <- read_delim(unz("CRS 2015 Data.zip", "CRS 2015 data.txt"), 
#                          delim = "|", guess_max = 250000)
# 
# 2016
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=b64f050c-4e2f-44ed-a8e6-db32ce00fd4f", 
#             "CRS 2016 Data.zip", quiet = FALSE) 
# crs_16_raw <- read_delim(unz("CRS 2016 Data.zip", "CRS 2016 data.txt"), 
#                        delim = "|", guess_max = 250000)

# For some reason unzip is not working, extracted manually. 
crs_16_raw <- read_delim("CRS 2016 data.txt", 
                         delim = "|", guess_max = 250000)

# 2017 
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=bf6e1a95-a4ac-4545-9e91-1a38c9b738de", 
#               "CRS 2017 Data.zip", quiet = FALSE) 
# crs_17_raw <- read_delim(unz("CRS 2017 Data.zip", "CRS 2017 data.txt"), 
#                          delim = "|", guess_max = 250000)

# For some reason unzip is not working, extracted manually. 
crs_17_raw <- read_delim("CRS 2017 data.txt", 
                         delim = "|", guess_max = 250000)

# 2018
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=ed94e89a-e81e-4718-ac69-2a51f5429657", 
#               "CRS 2018 Data.zip", quiet = FALSE) 
# crs_18_raw <- read_delim(unz("CRS 2018 Data.zip", "CRS 2018 data.txt"), 
#                          delim = "|", guess_max = 250000)

# For some reason unzip is not working, extracted manually. 
crs_18_raw <- read_delim("CRS 2018 data.txt", 
                         delim = "|", guess_max = 250000)

# 2019 
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=348f223c-7d11-43ad-ab95-b7c0ab537fdd", 
#               "CRS 2019 Data.zip", quiet = FALSE) 
# crs_19_raw <- read_delim(unz("CRS 2019 Data.zip", "CRS 2019 data.txt"), 
#                          delim = "|", guess_max = 250000)

# For some reason unzip is not working, extracted manually. 
crs_19_raw <- read_delim("CRS 2019 data.txt", 
                         delim = "|", guess_max = 250000)

# 2020 
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=ac3a59f6-5acb-4747-9ef3-3c00e2ab3eb5", 
#               "CRS 2020 Data.zip", quiet = FALSE) 
# crs_20_raw <- read_delim(unz("CRS 2020 Data.zip", "CRS 2020 data.txt"), 
#                          delim = "|", guess_max = 250000)

# For some reason unzip is not working, extracted manually. 
crs_20_raw <- read_delim("CRS 2020 data.txt", 
                         delim = "|", guess_max = 250000)

# # DEPRECATED Clipping empty rows -----------------------------------------
# # Appears that this issues was solved with the latest update of the CRS. 

# # Clipping the last empty row that raises a parsing flag. This may be a 
# # Mac-specific issue. Parsing errors will flag this for each file, ignore this 
# # section if it doesn't appear. 
# ## Example: Warning: 1 parsing failure.
# ##          row col   expected    actual         file
# ##          225040  -- 91 columns 1 columns <connection>
# 
# # crs_14_raw <- crs_14_raw[-nrow(crs_14_raw),]
# # crs_15_raw <- crs_15_raw[-nrow(crs_15_raw),]
# # crs_16_raw <- crs_16_raw[-nrow(crs_16_raw),]
# crs_17_raw <- crs_17_raw[-nrow(crs_17_raw),]
# crs_18_raw <- crs_18_raw[-nrow(crs_18_raw),]
# crs_19_raw <- crs_19_raw[-nrow(crs_19_raw),]
# crs_20_raw <- crs_20_raw[-nrow(crs_20_raw),]
# 
# 
# Redefining variables for binding ----------------------------------------

# Defining the list for additional year analysis. Not used. 
# raw_list <- list(crs_14_raw, crs_15_raw, crs_16_raw,
#                  crs_17_raw, crs_18_raw, crs_19_raw)

raw_list <- list(crs_16_raw, crs_17_raw, crs_18_raw, crs_19_raw, crs_20_raw)

# Check new 2020 columns
colnames_2019 <- colnames(crs_19_raw)
colnames_2020 <- colnames(crs_20_raw)
colnames_2020 %notin% colnames_2019
colnames_2020[55:56]

crs_20_raw <- crs_20_raw %>%
  select(-c("LDCflag", "LDCflagName"))

# Columns that need to be numeric:
numcols <- c("Year", "DonorCode", "AgencyCode", "InitialReport", "RecipientCode",
             "RegionCode", "IncomegroupCode", "FlowCode", "Bi_Multi", "Category",
             "Finance_t", "USD_Commitment", "USD_Disbursement", "USD_Received",
             "USD_Commitment_Defl", "USD_Disbursement_Defl", "USD_Received_Defl",
             "USD_Adjustment", "USD_Adjustment_Defl", "USD_AmountUntied", 
             "USD_AmountPartialTied", "USD_AmountTied", "USD_AmountUntied_Defl",
             "USD_AmountPartialTied_Defl", "USD_Amounttied_Defl", "USD_IRTC",
             "USD_Expert_Commitment", "USD_Expert_Extended", "USD_Expert_Credit",
             "CurrencyCode", "Commitment_National", "Disbursement_National",
             "GrantEquiv", "USD_GrantEquiv", "PurposeCode", "SectorCode", 
             "ChannelCode", "ParentChannelCode", "Gender", "Environment", "PDGG",
             "Trade", "RMNCH", "DRR", "Nutrition", "Disability", "FTC", "PBA",
             "InvestmentProject", "AssocFinance", "Biodiversity",
             "ClimateMitigation", "ClimateAdaptation", "Desertification", 
             "TypeRepayment", "NumberRepayment", "Interest2", "USD_Interest", 
             "USD_Outstanding", "USD_Arrears_Principal", "USD_Arrears_Interest",
             "BudgetIdent", "CapitalExpend", "PSIflag", "PSIAddType")
chrcols <- c("DonorName", "AgencyName", "CRSID", "ProjectNumber", "RecipientName",
             "RegionName", "IncomegroupName", "FlowName", "Aid_t", 
             "ShortDescription", "ProjectTitle", "PurposeName", "SectorName",
             "ChannelName", "ChannelReportedName", "Geography", "LongDescription",
             "SDGfocus", "Interest1", "PSIAddAssess", "PSIAddDevObj",
             "ExpectedStartDate", "CompletionDate", "CommitmentDate", 
             "Repaydate1", "Repaydate2")


# nums14 <- colnames(crs_14_raw) %in% numcols
# crs_14_raw[nums14] <- lapply(crs_14_raw[nums14], as.numeric)
# chrs14 <- colnames(crs_14_raw) %in% chrcols
# crs_14_raw[chrs14] <- lapply(crs_14_raw[chrs14], as.character)

# nums15 <- colnames(crs_15_raw) %in% numcols
# crs_15_raw[nums15] <- lapply(crs_15_raw[nums15], as.numeric)
# chrs15 <- colnames(crs_15_raw) %in% chrcols
# crs_15_raw[chrs15] <- lapply(crs_15_raw[chrs15], as.character)

nums16 <- colnames(crs_16_raw) %in% numcols
crs_16_raw[nums16] <- lapply(crs_16_raw[nums16], as.numeric)
chrs16 <- colnames(crs_16_raw) %in% chrcols
crs_16_raw[chrs16] <- lapply(crs_16_raw[chrs16], as.character)

nums17 <- colnames(crs_17_raw) %in% numcols
crs_17_raw[nums17] <- lapply(crs_17_raw[nums17], as.numeric)
chrs17 <- colnames(crs_17_raw) %in% chrcols
crs_17_raw[chrs17] <- lapply(crs_17_raw[chrs17], as.character)

nums18 <- colnames(crs_18_raw) %in% numcols
crs_18_raw[nums18] <- lapply(crs_18_raw[nums18], as.numeric)
chrs18 <- colnames(crs_18_raw) %in% chrcols
crs_18_raw[chrs18] <- lapply(crs_18_raw[chrs18], as.character)

nums19 <- colnames(crs_19_raw) %in% numcols
crs_19_raw[nums19] <- lapply(crs_19_raw[nums19], as.numeric)
chrs19 <- colnames(crs_19_raw) %in% chrcols
crs_19_raw[chrs19] <- lapply(crs_19_raw[chrs19], as.character)

nums20 <- colnames(crs_20_raw) %in% numcols
crs_20_raw[nums20] <- lapply(crs_20_raw[nums20], as.numeric)
chrs20 <- colnames(crs_20_raw) %in% chrcols
crs_20_raw[chrs20] <- lapply(crs_20_raw[chrs20], as.character)

# Binding rows for additional year analysis. Not used. 
# crs_raw_full <- bind_rows(crs_14_raw, crs_15_raw, crs_16_raw,
#                           crs_17_raw, crs_18_raw, crs_19_raw, crs_20_raw)

crs_raw_full <- bind_rows(crs_16_raw, crs_17_raw, crs_18_raw, 
                          crs_19_raw, crs_20_raw)

## Checking for grants vs. loans after 6/24 call w. IMF 

# table(crs_raw_full$flow_name)
# crs_raw_full %>%
#   group_by(FlowName) %>%
#   summarise(sum = sum(USD_Disbursement, na.rm = T), sum_grant = sum(USD_GrantEquiv, na.rm = T))

# FlowName                                     sum sum_grant
# <chr>                                      <dbl>     <dbl>
# 1 Equity Investment                          6274     4819
# 2 ODA Grants                               588875   509298
# 3 ODA Loans                                208360    52612
# 4 Other Official Flows (non Export Credit) 281662        0 
# 5 Private Development Finance               36191        0 

# For 2014-2019: This trims the dataset down from 1526619 to 1289868 projects, 
# and reduces total disbursements from  $1.52 trillion to $853 billion.

# For 2016-2020: This trims the dataset down from 1170820 to 993144 projects, 
# and reduces total disbursements from  $1.12 trillion to $625 billion.






# Pre-processed datasets --------------------------------------------------
### LOOK OUT FOR AUSTIN LIST

smlcols <- c("Year", "DonorCode", "DonorName", "AgencyCode", "AgencyName",
             "RecipientCode", "RecipientName", 
             "FlowCode", "FlowName", "Category", "Aid_t", 
             "Finance_t", "USD_Disbursement",
             "USD_Expert_Commitment", "USD_Expert_Extended", "PurposeCode",
             "PurposeName", "SectorCode", "SectorName", "ProjectTitle",
             "ShortDescription", "LongDescription", "ChannelCode", 
             "ChannelName", "ChannelReportedName", "ParentChannelCode",
             "Gender", "ClimateMitigation", "ClimateAdaptation")

crs_raw_small <- crs_raw_full %>%
  select(smlcols) %>%
  rename(year = Year, donor_code = DonorCode, donor_name = DonorName, 
         agency_code = AgencyCode, agency_name = AgencyName,  
         recipient_code = RecipientCode, recipient_name = RecipientName, 
         flow_code = FlowCode, flow_name = FlowName,  
         aid_t_code = Category, aid_type = Aid_t,
         finance_type = Finance_t, disbursement_usd = USD_Disbursement,
         expert_commitment = USD_Expert_Commitment, 
         expert_extended = USD_Expert_Extended, purpose_code = PurposeCode,
         purpose_name = PurposeName, sector_code = SectorCode, 
         sector_name = SectorName, project_title = ProjectTitle,
         short_description = ShortDescription, 
         long_description = LongDescription, channel_code = ChannelCode, 
         channel_name = ChannelName, 
         channel_reported_name = ChannelReportedName, 
         parent_channel_code = ParentChannelCode,
         gender = Gender, 
         climate_mitigation = ClimateMitigation,
         climate_adaptation = ClimateAdaptation)

crs_raw_small$year <- as.character(crs_raw_small$year)

# Confirm data is saved in "raw_oecd_bulk_data". 
getwd()
# setwd("..")
# setwd("./raw_oecd_bulk_data")

write_csv(crs_raw_full, "crs_raw_full.csv")
write_csv(crs_raw_small, "crs_raw_small.csv")
setwd("..")
setwd("..")








# New download format:  ---------------------------------------------------

# Packages ----------------------------------------------------------------

library(tidyverse)
library(janitor)
library(openxlsx)
library(extrafont)
library(treemap) 

options(scipen = 999)

`%notin%` <- Negate(`%in%`)

setwd("~/Documents/AidData/Data2x r2/")

# Read in Data ------------------------------------------------------------
list.files()
options(timeout = 120)

setwd("~/Documents/AidData/Data2x r2/oecd_crs_raw")

# # No longer relying on Excel, figured out the encoding issues finally
# # deu <- readxl::read_excel("combo_germany_base_template.xlsx", 
# #                           sheet = 2,
# #                           guess_max = 60000)
# 
# tmp_dir <- tempdir()
# tmp <- tempfile(tmpdir = tmp_dir)
# 
# # 2017 
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=bf6e1a95-a4ac-4545-9e91-1a38c9b738de", 
#               tmp, quiet = FALSE) 
# outf <- unzip(tmp, list = T)$Name
# unzip(tmp, outf, exdir = tmp_dir)
# crs_17_raw <- read.delim(file.path(tmp_dir, outf), sep = "|", fileEncoding = "UTF-16") %>%
#   janitor::clean_names() %>%
#   filter(donor_code == 5)
#   
# # 2018
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=ed94e89a-e81e-4718-ac69-2a51f5429657", 
#               tmp, quiet = FALSE) 
# outf <- unzip(tmp, list = T)$Name
# unzip(tmp, outf, exdir = tmp_dir)
# crs_18_raw <- read.delim(file.path(tmp_dir, outf), sep = "|", fileEncoding = "UTF-16") %>%
#   janitor::clean_names() %>%
#   filter(donor_code == 5)
# 
# # 2019 
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=348f223c-7d11-43ad-ab95-b7c0ab537fdd", 
#               tmp, quiet = FALSE) 
# outf <- unzip(tmp, list = T)$Name
# unzip(tmp, outf, exdir = tmp_dir)
# crs_19_raw <- read.delim(file.path(tmp_dir, outf), sep = "|", fileEncoding = "UTF-16") %>%
#   janitor::clean_names() %>%
#   filter(donor_code == 5)
#  
# # 2020
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=ac3a59f6-5acb-4747-9ef3-3c00e2ab3eb5", 
#               tmp, quiet = FALSE) 
# outf <- unzip(tmp, list = T)$Name
# unzip(tmp, outf, exdir = tmp_dir)
# crs_20_raw <- read.delim(file.path(tmp_dir, outf), sep = "|", fileEncoding = "UTF-16") %>%
#   janitor::clean_names() %>%
#   filter(donor_code == 5)
# 
# # 2021
# download.file("https://stats.oecd.org/FileView2.aspx?IDFile=d85be660-7811-45c1-b807-810b42055259", 
#               tmp, quiet = FALSE) 
# outf <- unzip(tmp, list = T)$Name
# unzip(tmp, outf, exdir = tmp_dir)
# crs_21_raw <- read.delim(file.path(tmp_dir, outf), sep = "|", fileEncoding = "UTF-16") %>%
#   janitor::clean_names() %>%
#   filter(donor_code == 5)
# 
# # Write raw
# setwd("~/Documents/AidData/Data2x r2/oecd_crs_raw")
# 
# write_csv(crs_17_raw, "deu_17_raw.csv")
# write_csv(crs_18_raw, "deu_18_raw.csv")
# write_csv(crs_19_raw, "deu_19_raw.csv")
# write_csv(crs_20_raw, "deu_20_raw.csv")
# write_csv(crs_21_raw, "deu_21_raw.csv")

crs_17_raw <- read_csv("deu_17_raw.csv")
crs_18_raw <- read_csv("deu_18_raw.csv")
crs_19_raw <- read_csv("deu_19_raw.csv")
crs_20_raw <- read_csv("deu_20_raw.csv")
crs_21_raw <- read_csv("deu_21_raw.csv")

# Fixing coltypes 
# # Columns that need to be numeric:
numcols <- c("Year", "DonorCode", "AgencyCode", "InitialReport", "RecipientCode",
             "RegionCode", "IncomegroupCode", "FlowCode", "Bi_Multi", "Category",
             "Finance_t", "USD_Commitment", "USD_Disbursement", "USD_Received",
             "USD_Commitment_Defl", "USD_Disbursement_Defl", "USD_Received_Defl",
             "USD_Adjustment", "USD_Adjustment_Defl", "USD_AmountUntied", 
             "USD_AmountPartialTied", "USD_AmountTied", "USD_AmountUntied_Defl",
             "USD_AmountPartialTied_Defl", "USD_Amounttied_Defl", "USD_IRTC",
             "USD_Expert_Commitment", "USD_Expert_Extended", "USD_Expert_Credit",
             "CurrencyCode", "Commitment_National", "Disbursement_National",
             "GrantEquiv", "USD_GrantEquiv", "PurposeCode", "SectorCode", 
             "ChannelCode", "ParentChannelCode", "Gender", "Environment", "PDGG",
             "Trade", "RMNCH", "DRR", "Nutrition", "Disability", "FTC", "PBA",
             "InvestmentProject", "AssocFinance", "Biodiversity",
             "ClimateMitigation", "ClimateAdaptation", "Desertification", 
             "TypeRepayment", "NumberRepayment", "interest1", "interest2", 
             "USD_Interest", "USD_Outstanding", "USD_Arrears_Principal", 
             "USD_Arrears_Interest", "BudgetIdent", "CapitalExpend", "PSIflag", 
             "PSIAddType")
chrcols <- c("DonorName", "AgencyName", "CRSID", "ProjectNumber", "RecipientName",
             "RegionName", "IncomegroupName", "FlowName", "Aid_t", 
             "ShortDescription", "ProjectTitle", "PurposeName", "SectorName",
             "ChannelName", "ChannelReportedName", "Geography", "LongDescription",
             "SDGfocus", "Interest1", "PSIAddAssess", "PSIAddDevObj")


nums17 <- colnames(crs_17_raw) %in% numcols
crs_17_raw[nums17] <- lapply(crs_17_raw[nums17], as.numeric)
chrs17 <- colnames(crs_17_raw) %in% chrcols
crs_17_raw[chrs17] <- lapply(crs_17_raw[chrs17], as.character)

nums18 <- colnames(crs_18_raw) %in% numcols
crs_18_raw[nums18] <- lapply(crs_18_raw[nums18], as.numeric)
chrs18 <- colnames(crs_18_raw) %in% chrcols
crs_18_raw[chrs18] <- lapply(crs_18_raw[chrs18], as.character)

nums19 <- colnames(crs_19_raw) %in% numcols
crs_19_raw[nums19] <- lapply(crs_19_raw[nums19], as.numeric)
chrs19 <- colnames(crs_19_raw) %in% chrcols
crs_19_raw[chrs19] <- lapply(crs_19_raw[chrs19], as.character)

nums20 <- colnames(crs_20_raw) %in% numcols
crs_20_raw[nums20] <- lapply(crs_20_raw[nums20], as.numeric)
chrs20 <- colnames(crs_20_raw) %in% chrcols
crs_20_raw[chrs20] <- lapply(crs_20_raw[chrs20], as.character)

nums21 <- colnames(crs_21_raw) %in% numcols
crs_21_raw[nums21] <- lapply(crs_21_raw[nums21], as.numeric)
chrs21 <- colnames(crs_21_raw) %in% chrcols
crs_21_raw[chrs21] <- lapply(crs_21_raw[chrs21], as.character)

deu <- bind_rows(crs_17_raw, crs_18_raw, crs_19_raw, crs_20_raw,
                 crs_21_raw)
rm(crs_17_raw, crs_18_raw, crs_19_raw, crs_20_raw, crs_21_raw, 
   chrs17, chrs18, chrs19, chrs20, chrs21, chrcols,
   nums17, nums18, nums19, nums20, nums21, numcols
)
gc()
