# ------------------ VIZ 1: MINERALS EXPORT VOLUMES ------------------ #
# Load required packages for plotting
install.packages("ggplot2")
library(ggplot2)
library(plotly)

# Create dual-line plot for Li and Ni export volumes with interactive tooltips
p1 <- ggplot(data = df, aes(x = FY_end)) +
  # Lithium line and points with hover text
  geom_line(aes(y = Li_xvol, color = "Li"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Li_xvol, color = "Li",
                 text = paste0("FY: ", FY, "\n", "Export Volume: ", round(Li_xvol, 1), " kT")),
             size = 1.5, na.rm = TRUE) +
  # Nickel line and points with hover text
  geom_line(aes(y = Ni_xvol, color = "Ni"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Ni_xvol, color = "Ni",
                 text = paste0("FY: ", FY, "\n", "Export Volume: ", round(Ni_xvol, 1), " kT")),
             size = 1.5, na.rm = TRUE) + 
  labs(title = "Fig 1: Australian Lithium and Nickel Export Volumes (1990-2024)",
       subtitle = "Lithium exports surge by 7.6x from 2016 to 2024",
       x = "Financial Year End", y = "Exports (kT)", color = "Commodity") +
  theme_classic() +
  # Set x-axis breaks at 5-year intervals plus 2024
  scale_x_continuous(breaks = c(seq(1990, 2020, by = 5), 2024)) +
  scale_y_continuous(breaks = seq(0, 4000, by = 1000), limits = c(0, 4000)) +
  # Define custom colours for minerals
  scale_color_manual(values = c("Li" = "darkorange", "Ni" = "deepskyblue3")) +
  theme(plot.title = element_text(face = "bold", size = 15, hjust = 0),
        plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15), face = "italic"),
        plot.caption = element_text(hjust = 0, color = "grey50", size = 9),
        axis.text = element_text(size = 11), axis.title = element_text(face = "bold", size = 11),
        axis.line = element_line(color = "grey50"),
        panel.grid.major.y = element_line(color = "grey90", linewidth = 0.5))
p1
# Convert to interactive plotly chart with custom tooltips
ggplotly(p1, tooltip = "text")

# ------------------ VIZ 2: MINERALS EXPORT VALUES ------------------  #
install.packages("ggplot2")
library(ggplot2)

# Create dual-line plot for Li and Ni export values (AU$ billions)
p2 <- ggplot(data = df, aes(x = FY_end)) +
  # Lithium export values
  geom_line(aes(y = Li_xval, color = "Li"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Li_xval, color = "Li",
                 text = paste0("FY: ", FY, "\n", "Export Value: $", round(Li_xval, 1), " Bil")),
             size = 1.5, na.rm = TRUE) +
  # Nickel export values
  geom_line(aes(y = Ni_xval, color = "Ni"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Ni_xval, color = "Ni",
                 text = paste0("FY: ", FY, "\n", "Export Value: $", round(Ni_xval, 1), " Bil")),
             size = 1.5, na.rm = TRUE) + 
  labs(title = "Fig 2: Australian Annual Export Values (FOB), Lithium and Nickel (1990-2024)",
       subtitle = "Lithium export values overtake Nickel in 2021, remaining at elevated levels into 2024",
       x = "Financial Year End", y = "Export Values (AU$ Bil)", color = "Commodity") +
  theme_classic() +
  # Dynamic y-axis based on max values in dataset
  scale_y_continuous(breaks = seq(0, max(df$Li_xval, df$Ni_xval, na.rm = TRUE), by = 5)) +
  scale_x_continuous(breaks = c(seq(1990, 2020, by = 5), 2024)) +
  scale_color_manual(values = c("Li" = "darkorange", "Ni" = "deepskyblue3")) + 
  theme(plot.title = element_text(face = "bold", size = 13, hjust = 0),
        plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15), face = "italic"),
        plot.caption = element_text(hjust = 0, color = "grey50", size = 9),
        axis.text = element_text(size = 10), axis.title = element_text(face = "bold", size = 11),
        axis.line = element_line(color = "grey50"),
        panel.grid.major.y = element_line(color = "grey90", linewidth = 0.5))
p2
ggplotly(p2, tooltip = "text")

# ------------------ VIZ 3: CRITICAL MINERALS INTERACTIVE MAP ------------------ #
# Load mine production data
library(readxl)
df7_updated <- read_excel("C:/Users/gemao/My Drive/05 Further Education & Learning/2024-25 UQ/BSAN7208 Visual Analytics/A1/Datasets/7-mines (ni updated).xlsx")
View(df7_updated)
# Load spatial and mapping libraries
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(tidyverse)
library(plotly)

# Prepare mine data: format production values and rename REE
df8 <- df7_updated %>% 
  mutate(Production_2023 = paste0(`2023 production (kT)`, ' kt'),
         Mineral = case_when(Mineral == 'REE' ~ 'Rare Earth Elements', TRUE ~ Mineral)) %>%
  arrange(desc(`2023 production (kT)`))

# Get Australia shapefile for map boundary
aus <- rnaturalearth::ne_countries(country = "australia", returnclass = "sf")

# Create spatial bubble map with mines sized by production volume
minesplot <- ggplot() +
  # Australia basemap
  geom_sf(data = aus, fill = "grey95", color = "grey80", linewidth = 0.4) +
  # Mine locations as points with size mapped to production
  geom_point(data = df8, aes(x = Longitude, y = Latitude, fill = Mineral, color = Mineral,
                             size = `2023 production (kT)`,
                             text = paste0("Mine: ", Mine, "<br>", "Mineral: ", Mineral, "<br>",
                                          "Production: ", Production_2023, "<br>", "Status: ", Status)),
             shape = 20, stroke = 0.5, alpha = 0.5) +
  # Zoom to mainland Australia
  coord_sf(xlim = c(112, 154), ylim = c(-44, -10), expand = FALSE) +
  # Define mineral colour palette
  scale_fill_manual(name = "Mineral Type (colour) and",
                    values = c("Nickel" = "#0072B2", "Lithium (spodumene)" = "#E69F00",
                              "Rare Earth Elements" = "#2D9B7E")) +
  scale_color_manual(values = c("Nickel" = "#004D80", "Lithium (spodumene)" = "#CC7A00",
                                "Rare Earth Elements" = "#2D9B7E"), guide = "none") +
  # Size legend for production volumes
  scale_size_continuous(name = "2023 Production kT (size)", range = c(1, 12),
                       breaks = c(0, 500, 1000, 1500), labels = c("0", "500", "1000", "2000")) +
  guides(fill = guide_legend(override.aes = list(size = 4), order = 1),
         size = guide_legend(override.aes = list(fill = "grey40", color = "grey20"), order = 2)) +
  labs(title = "Fig 3: Australian Mines Producing Select Critical Minerals (2023)", x = NULL, y = NULL) +
  theme_void() +
  theme(plot.title = element_text(face = "bold", size = 14, hjust = 0),
        plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15)),
        plot.caption = element_text(hjust = 0, color = "grey50", size = 9),
        legend.title = element_text(face = "bold", size = 11),
        legend.text = element_text(size = 10))
ggplotly(minesplot, tooltip = "text")

# ------------------ VIZ 4: LITHIUM PRODUCTION AUS VS ROW ------------------ #
library(ggplot2)
library(tidyverse)
library(scales)

# Load global lithium production dataset
df_lithium <- read_csv("lithium-production.csv")
colnames(df_lithium) <- c("Country", "Code", "Year", "Production_kt")

# Filter to 2004-2024 and remove aggregate regions (keep only countries)
df_lithium <- df_lithium %>%
  filter(Year >= 2004 & Year <= 2024) %>%
  filter(!Country %in% c("World", "High-income countries", "Low-income countries", 
                         "Lower-middle-income countries", "Upper-middle-income countries",
                         "Oceania", "Africa", "Asia", "Europe", "North America", 
                         "South America", "Central America", "Middle East",
                         "European Union", "OECD Countries", "G20"))

# Calculate global production totals by year
global_totals <- df_lithium %>%
  group_by(Year) %>%
  summarise(Total = sum(Production_kt, na.rm = TRUE))

# Identify top 3 producing countries in most recent year
top_countries <- df_lithium %>%
  filter(Year == max(Year)) %>%
  arrange(desc(Production_kt)) %>%
  head(3) %>%
  pull(Country)
print("Top 3 lithium producing countries (latest year):")
print(top_countries)

# Group countries into Top 3 + Rest of World categories
df_area <- df_lithium %>%
  mutate(Country_Group = ifelse(Country %in% top_countries, Country, "Rest of World")) %>%
  group_by(Year, Country_Group) %>%
  summarise(Production_kt = sum(Production_kt, na.rm = TRUE), .groups = 'drop') %>%
  mutate(Production_Mt = Production_kt / 1000)  # Convert to megatonnes

# Order countries by peak production (for stacking order)
country_order <- df_area %>%
  group_by(Country_Group) %>%
  summarise(Max_Production = max(Production_Mt)) %>%
  arrange(desc(Max_Production)) %>%
  pull(Country_Group)
df_area$Country_Group <- factor(df_area$Country_Group, levels = rev(country_order))

# Data validation
print("\nData summary:")
print(summary(df_area))
print("\nSample of prepared data:")
print(head(df_area, 15))

# Colour palette: Australia highlighted, others muted
colors <- c("Australia" = "#2D9B7E", "Chile" = "#D4B86A",
           "China" = "#C9977C", "Rest of World" = "#CCCCCC")

# Create stacked area chart showing production by country over time
p_area <- ggplot(df_area, aes(x = Year, y = Production_Mt, fill = Country_Group)) +
  geom_area(alpha = 0.85, color = "white", linewidth = 0.3) +
  scale_fill_manual(values = colors, name = "Country") +
  scale_x_continuous(breaks = seq(2004, 2024, by = 5)) +
  scale_y_continuous(labels = comma_format(suffix = " Mt"),
                    breaks = function(x) { b <- pretty_breaks(n = 6)(x); b[b != 0] },
                    expand = expansion(mult = c(0, 0.05))) +
  labs(title = "Fig 4: Global lithium production by country (2004-2024)",
       subtitle = "Australia overtakes as the largest global producer in 2014",
       x = "Year", y = "Lithium Production (Mega Tonnes)") +
  theme_classic() +
  theme(plot.title = element_text(face = "bold", size = 16, hjust = 0),
        plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15), face = "italic"),
        plot.caption = element_text(hjust = 0, color = "grey50", size = 9),
        legend.position = "right", legend.title = element_text(face = "bold", size = 11),
        legend.text = element_text(size = 10), panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(color = "grey90", linewidth = 0.3),
        panel.background = element_blank(), plot.background = element_rect(fill = "white", color = NA),
        axis.text = element_text(size = 10), axis.title = element_text(face = "bold", size = 11),
        axis.line = element_line(color = "grey50"))

# Add vertical line marking year Australia became #1 producer
overtake_year <- 2014
p_area <- p_area + geom_vline(xintercept = overtake_year, linetype = "dotted", color = "black",
                              linewidth = 0.6, alpha = 0.5)
print(p_area)

# ------------------ VIZ 5: MINES AND CAPAD OVERLAP MAP------------------ #
# Load spatial analysis libraries
library(sf); library(ggplot2); library(dplyr); library(ozmaps); library(leaflet)

# Check coordinate reference system of mine data
st_crs(df_ga)

# Filter WA mines and create spatial points (GDA94 projection)
mines_wa <- df_ga %>% filter(State == "WA") %>% st_drop_geometry() %>% 
  st_as_sf(coords = c("Longitude","Latitude"), crs = 4283)

# Get WA state boundary from ozmaps package
wa_boundary <- ozmap_states %>% filter(NAME == "Western Australia") %>% 
  st_transform(4283) %>% st_cast("MULTIPOLYGON")

# Clean CAPAD protected areas: fix invalid geometries, keep only polygons
capad_wa_clean <- capad_wa %>% st_make_valid() %>% 
  filter(st_geometry_type(.) %in% c("POLYGON","MULTIPOLYGON"))

# Verify spatial extents match
st_bbox(mines_wa); st_bbox(capad_wa_clean); st_bbox(wa_boundary)

# Create static map showing mines over protected areas
capad_plot <- ggplot() +
  geom_sf(data = wa_boundary, fill = NA, color = "grey60", linewidth = 0.5) +
  geom_sf(data = capad_wa_clean, fill = "darkgreen", color = "grey40", linewidth = 0.2, alpha = 0.6) +
  geom_sf(data = mines_wa, color = "darkred", size = 2, alpha = 0.8) +
  labs(title = "Mines in Western Australia over CAPAD 2024 (Terrestrial)") +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text = element_blank(), axis.ticks = element_blank())

# Prepare data for interactive Leaflet map (WGS84 projection)
capad_wa_leaflet <- capad_wa %>% st_transform(4326) %>% st_make_valid() %>% 
  filter(st_geometry_type(.) %in% c("POLYGON","MULTIPOLYGON"))
mines_leaflet <- st_transform(mines_wa, 4326)

# Disable spherical geometry for spatial join
sf_use_s2(FALSE)

# Spatial join: identify which mines fall within protected areas
mines_with_capad <- st_join(mines_leaflet, capad_wa_leaflet, join = st_within) %>%
  mutate(in_capad = !is.na(PA_ID), 
         mine_color = ifelse(in_capad, "#E66101", "#5E3C99"))  # Orange if overlap, purple if not

# Create interactive Leaflet map with protected areas and mines
leaflet() %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  # Add protected areas as green polygons
  addPolygons(data = capad_wa_leaflet, fillColor = "#2D6A4F", fillOpacity = 0.5,
              color = "#2D6A4F", weight = 0.1, label = ~paste0(NAME," (",TYPE,")"),
              popup = ~paste0("<b>",NAME,"</b><br>Type: ",TYPE,"<br>IUCN Category: ",IUCN)) %>%
  # Add mines as coloured circles (orange = in protected area, purple = outside)
  addCircleMarkers(data = mines_with_capad, radius = 4, color = ~mine_color,
                   fillColor = ~mine_color, fillOpacity = 0.8, stroke = TRUE, weight = 1,
                   label = ~lapply(paste0("Mine: ", Name, "<br>Status: ", Status,
                                         "<br>Commodity Group: ", `Commodity Group`), htmltools::HTML),
                   popup = ~paste0("<b>", Name, "</b><br>Commodity: ", `Commodity Group`,
                                  "<br>Status: ", Status)) %>%
  # Add legend explaining colours
  addLegend("bottomright", colors = c("#2D6A4F","#E66101","#5E3C99"),
            labels = c("CAPAD 2024 Protected Areas","Mines in Protected Areas",
                      "Mines Outside Protected Areas"), title = "Legend", opacity = 1)

# ------------------ DEPLOY TO SHINY -------------------- #
install.packages('rsconnect')
rsconnect::setAccountInfo(name='', token='')
rsconnect::deployApp('')
