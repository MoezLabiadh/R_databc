library(bcdata)
library(sf)
library(dplyr)
library(writexl)



# Get land districts and filter based on conditions
districts <- bcdc_query_geodata("WHSE_TANTALIS.TA_LAND_DISTRICTS_SVW") %>%
  
            filter(LAND_DISTRICT_NAME %in% c("NANAIMO DISTRICT","SAYWARD DISTRICT")) %>%
  
            collect()



# Get tenures intersecting with districts
tenures <- bcdc_query_geodata("WHSE_TANTALIS.TA_CROWN_TENURES_SVW") %>%
           filter(TENURE_PURPOSE == "AQUACULTURE"&
                  TENURE_STAGE == "APPLICATION" &
                  APPLICATION_TYPE_CDE == "NEW") %>%

           collect()


intersect <- tenures %>%
            st_join(districts, left = FALSE)


write_xlsx(intersect,"\\\\sfp.idir.bcgov\\...export.xlsx")


# Plot Results
intersect  %>%
  ggplot() +
  geom_sf() +
  theme_minimal()

