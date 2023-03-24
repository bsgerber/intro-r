# R Cafe Using REDCap API

# If not installed, then install
# install.packages("REDCapR")
library(REDCapR)

# Know about securing credentials (needed for API)
# https://solutions.posit.co/connections/db/best-practices/managing-credentials/

# keyring package uses the operating system's credential storage
# install.packages("keyring")
library(keyring)

# On my mac, this gives a popup window where I can enter the API Token from REDCap
# keyring::key_set(service = "REDCap API"...)

# Read data from REDCap
ds_1 <- REDCapR::redcap_read(
  redcap_uri = key_list("REDCap API")[1,2],
  token = key_get("REDCap API")
)

# Describe object returned
str(ds_1)

# Where's the data?
ds_1$data

# Example look
table(ds_1$data$id_language)

# Get specific records
ds_2 <- REDCapR::redcap_read(
  redcap_uri = key_list("REDCap API")[1,2],
  token = key_get("REDCap API"),
  records = c(1, 3, 5)
)

# What data has the three records?
ds_2$data

# Get records with specific filter
ds_3 <- REDCapR::redcap_read(
  redcap_uri = key_list("REDCap API")[1,2],
  token = key_get("REDCap API"),
  filter_logic = "[id_language] = 'English'",
  fields = c("record_id", "id_language", "q1")
)

# What data is there?
ds_3$data

# Try another package
# install.packages("REDCapTidieR")
library(REDCapTidieR)

# Get the data with new package
ds_4 <- read_redcap(key_list("REDCap API")[1,2], key_get("REDCap API"))

# What class does it return? A tibble (or supertibble!)
class(ds_4)

# View the tibble
View(ds_4)

# Get the form data (extract)
ds_4 |>
  extract_tibble("form_1")

# Look at data
str(ds_4[["redcap_data"]])

# Use labels
ds_4 |>
  make_labelled() |> # Apply variable labels to the columns
  bind_tibbles()     # Bind data to global environment 

# Use look for to find variable/object in environment
labelled::look_for(form_1)

# Show results with labels
str(form_1)
