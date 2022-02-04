library(bcdata)

## Search databc catalogue for keyword
bcdc_search("crown tenures")

## Get the metadata for the Crown Tenure dataset
tenure_metadata <- bcdc_get_record("tantalis-crown-tenures")

## Get info on columns
data_info <- bcdc_describe_feature(tenure_metadata)


# Get data and filter based on conditions
tenure <- bcdc_query_geodata(tenure_metadata) %>%
          filter(RESPONSIBLE_BUSINESS_UNIT == "VI - LAND MGMNT - VANCOUVER ISLAND SERVICE REGION" &
                 TENURE_PURPOSE == "AQUACULTURE"&
                 TENURE_STAGE == "APPLICATION" &
                 APPLICATION_TYPE_CDE == "NEW") %>%
          collect()

# Plot Results
tenure  %>%
  ggplot() +
  geom_sf() +
  theme_minimal()
