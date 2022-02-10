library (sf)
library(bcdata)
library(dplyr)
library (ggplot2)
library(writexl)

# Read Harvest Area feature class
ha_gdb <- "\\\\sfp.idir.bcgov\\S164\\S63087\\Share\\FrontCounterBC\\Moez\\WORKSPACE\\20211125_aquaPlants_FN_consult\\data.gdb"
ha_n <- "Harvest_areas_2022_all"

ha <- sf::st_read(ha_gdb, layer = ha_n)

# Read Rockfish areas feature class
rf_gdb <- "\\\\sfp.idir.bcgov\\S164\\S63087\\Share\\FrontCounterBC\\Moez\\WORKSPACE\\20211018_aquaPlants_dfo\\2022HarvestAreas_mapping\\harvest_areas_working.gdb"
rf_n <- "aoi_DFO_ROCKFISH_CONS_AREA_SVW_2020"

rf <- sf::st_read(rf_gdb, layer = rf_n)


# check if geometry is MULTISURFACE or MULTIPOLYGON
as.data.frame(table(st_geometry_type(ha)))

#casting to MULTIPOLYGON
ha = st_cast(ha, "MULTIPOLYGON")


intersect <- ha %>%
             st_join(districts, left = FALSE)


join <- st_join(ha, rf, join=st_intersects, left = FALSE)

write_xlsx(join,"\\\\sfp.idir.bcgov\\S164\\S63087\\Share\\FrontCounterBC\\Moez\\Training\\R\\myCodes\\outputs\\join.xlsx")

