# Load libraries
library(shiny);library(ggplot2);library(plotly);library(leaflet);library(sf);library(DT);library(dplyr);library(readxl);library(rnaturalearth);library(rnaturalearthdata);library(tidyverse);library(scales);library(ozmaps);library(readr)

# Load data
df_updated <- read_csv("df_updated.csv") #p1 & p2
df8 <- read_csv("df_cmmap.csv") # For minesplot
df_lithium <- read_csv("df_lithium.csv") # For areaplot
df_ga <- read_csv("df_ga.csv") # For CAPAD map
capad_wa <- st_read("capad_wa_simple.shp")

# Prepare p1 plot
p1 <- ggplot(data = df_updated, aes(x = FY_end)) +
  geom_line(aes(y = Li_xvol, color = "Li"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Li_xvol, color = "Li", text = paste0("FY: ", FY, "\nExport Volume: ", round(Li_xvol, 1), " kT")), size = 1.5, na.rm = TRUE) +
  geom_line(aes(y = Ni_xvol, color = "Ni"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Ni_xvol, color = "Ni", text = paste0("FY: ", FY, "\nExport Volume: ", round(Ni_xvol, 1), " kT")), size = 1.5, na.rm = TRUE) + 
  geom_line(aes(y = Cu_xvol, color = "Cu"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Cu_xvol, color = "Cu", text = paste0("FY: ", FY, "\nExport Volume: ", round(Cu_xvol, 1), " kT")), size = 1.5, na.rm = TRUE) + 
  labs(title = "Fig 1: Australian Critical Minerals Export Volumes (1990-2025)", subtitle = "Lithium exports surge by 7.6x from 2016 to 2024", x = " ", y = "Exports (kT)", color = "Commodity") +
  theme_classic() + 
  scale_x_continuous(breaks = seq(1990, 2025, by = 5), limits = c(1990, 2025)) + 
  scale_y_continuous(breaks = seq(0, 4000, by = 1000), limits = c(0, 4000)) + 
  scale_color_manual(values = c("Li" = "deepskyblue3", "Ni" = "#5E3C99", "Cu" = "darkorange")) +  
  theme(plot.title = element_text(size = 13, hjust = 0), plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15), face = "italic"), plot.caption = element_text(hjust = 0, color = "grey50", size = 9), axis.text = element_text(size = 11), axis.title = element_text(face = "bold", size = 11), axis.line = element_line(color = "grey50"), panel.grid.major.y = element_line(color = "grey90", linewidth = 0.5))

# Prepare p2 plot
p2 <- ggplot(data = df_updated, aes(x = FY_end)) +
  geom_line(aes(y = Li_xval, color = "Li"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Li_xval, color = "Li", text = paste0("FY: ", FY, "\nExport Value: $", round(Li_xval, 1), " Bil")), size = 1.5, na.rm = TRUE) +
  geom_line(aes(y = Ni_xval, color = "Ni"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Ni_xval, color = "Ni", text = paste0("FY: ", FY, "\nExport Value: $", round(Ni_xval, 1), " Bil")), size = 1.5, na.rm = TRUE) + 
  geom_line(aes(y = Cu_xval, color = "Cu"), linewidth = 0.8, na.rm = TRUE) +
  geom_point(aes(y = Cu_xval, color = "Cu", text = paste0("FY: ", FY, "\nExport Value: $", round(Cu_xval, 1), " Bil")), size = 1.5, na.rm = TRUE) + 
  labs(title = "Fig 2: Australian Critical Minerals Export Values (FOB) (1990-2025)", subtitle = "Lithium export values overtake Nickel in 2021, remaining at elevated levels into 2025", x = " ", y = "Exports (AU$ Bil)", color = "Commodity") +
  theme_classic() + 
  scale_y_continuous(breaks = seq(0, 20, by = 5), limits = c(0, 20.2)) + 
  scale_x_continuous(breaks = seq(1990, 2025, by = 5), limits = c(1990, 2025)) + 
  scale_color_manual(values = c("Li" = "deepskyblue3", "Ni" = "#5E3C99", "Cu" = "darkorange")) + 
  theme(plot.title = element_text(size = 13, hjust = 0), plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15), face = "italic"), plot.caption = element_text(hjust = 0, color = "grey50", size = 9), axis.text = element_text(size = 10), axis.title = element_text(face = "bold", size = 11), axis.line = element_line(color = "grey50"), panel.grid.major.y = element_line(color = "grey90", linewidth = 0.5))

# Prepare minesplot
aus <- rnaturalearth::ne_countries(country = "australia", returnclass = "sf")
minesplot <- ggplot() + geom_sf(data = aus, fill = "grey95", color = "grey80", linewidth = 0.4) +
  geom_point(data = df8, aes(x = Longitude, y = Latitude, fill = Mineral, color = Mineral, size = `2023 production (kT)`, text = paste0("Mine: ", Mine, "<br>Mineral: ", Mineral, "<br>Production: ", Production_2023, "<br>Status: ", Status)), shape = 21, stroke = 0.5, alpha = 0.8) +
  coord_sf(xlim = c(112, 154), ylim = c(-44, -10), expand = FALSE) +
  scale_fill_manual(name = "Mineral Type (colour) and", values = c("Nickel" = "deepskyblue3", "Lithium (spodumene)" = "darkorange", "Rare Earth Elements" = "brown2")) +
  scale_color_manual(values = c("Nickel" = "deepskyblue4", "Lithium (spodumene)" = "darkorange4", "Rare Earth Elements" = "darkred"), guide = "none") +
  scale_size_continuous(name = "2023 Production kT (size)", range = c(3, 20), breaks = c(0, 500, 1000, 1500), labels = c("0", "500", "1000", "1500")) +
  guides(fill = guide_legend(override.aes = list(size = 4), order = 1), size = guide_legend(override.aes = list(fill = "grey40", color = "grey20"), order = 2)) +
  labs(title = "Fig 3: Australian Mines Producing Select Critical Minerals (2023)", x = NULL, y = NULL) + theme_void() +
  theme(plot.title = element_text(size = 13, hjust = 0), plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15)), plot.caption = element_text(hjust = 0, color = "grey50", size = 9), legend.title = element_text(face = "bold", size = 11), legend.text = element_text(size = 10))

# Prepare lithium area plot
top_countries <- df_lithium %>% filter(Year == max(Year)) %>% arrange(desc(Production_kt)) %>% head(3) %>% pull(Country)
df_area <- df_lithium %>% mutate(Country_Group = ifelse(Country %in% top_countries, Country, "Rest of World")) %>% group_by(Year, Country_Group) %>% summarise(Production_kt = sum(Production_kt, na.rm = TRUE), .groups = 'drop') %>% mutate(Production_Mt = Production_kt / 1000)
country_order <- df_area %>% group_by(Country_Group) %>% summarise(Max_Production = max(Production_Mt)) %>% arrange(desc(Max_Production)) %>% pull(Country_Group)
df_area$Country_Group <- factor(df_area$Country_Group, levels = rev(country_order))
colors <- c("Australia" = "#2D9B7E", "Chile" = "#D4B86A", "China" = "#C9977C", "Rest of World" = "#CCCCCC")
p_area <- ggplot(df_area, aes(x = Year, y = Production_Mt, fill = Country_Group)) + geom_area(alpha = 0.85, color = "white", linewidth = 0.3) +
  scale_fill_manual(values = colors, name = "Country") + scale_x_continuous(breaks = seq(2004, 2024, by = 5)) +
  scale_y_continuous(labels = comma_format(suffix = " Mt"), breaks = function(x) { b <- pretty_breaks(n = 6)(x); b[b != 0] }, expand = expansion(mult = c(0, 0.05))) +
  labs(title = "Fig 4: Global lithium production by country (2004-2024)", subtitle = "Australia overtakes as the largest global producer in 2014", x = " ", y = "Lithium Production (mt)") +
  theme_classic() + theme(plot.title = element_text(size = 13, hjust = 0), plot.subtitle = element_text(size = 12, color = "grey30", hjust = 0, margin = margin(b = 15), face = "italic"), plot.caption = element_text(hjust = 0, color = "grey50", size = 9), legend.position = "right", legend.title = element_text(face = "bold", size = 11), legend.text = element_text(size = 10), panel.grid.minor = element_blank(), panel.grid.major.x = element_blank(), panel.grid.major.y = element_line(color = "grey90", linewidth = 0.3), panel.background = element_blank(), plot.background = element_rect(fill = "white", color = NA), axis.text = element_text(size = 10), axis.title = element_text(face = "bold", size = 11), axis.line = element_line(color = "grey50")) +
  geom_vline(xintercept = 2014, linetype = "dotted", color = "black", linewidth = 0.6, alpha = 0.5)

# Prepare CAPAD map
sf_use_s2(FALSE)
capad_wa <- st_read("capad_wa_simple.shp")
mines_wa <- df_ga %>% filter(State == "WA") %>% st_drop_geometry() %>% st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326)
capad_wa_leaflet <- capad_wa %>% st_make_valid() %>% filter(st_geometry_type(.) %in% c("POLYGON", "MULTIPOLYGON"))
mines_leaflet <- st_transform(mines_wa, 4326)
mines_with_capad <- st_join(mines_leaflet, capad_wa_leaflet, join = st_within) %>% mutate(in_capad = !is.na(PA_ID), mine_color = ifelse(in_capad, "#E66101", "#5E3C99"))
capad_wa_clean <- capad_wa %>% st_make_valid()
mines_overlap <- st_join(mines_wa, capad_wa_clean, join = st_within) %>% filter(!is.na(NAME)) %>% st_drop_geometry() %>% select(Name, Status, `Commodity Group`, Protected_Area = NAME)
sf_use_s2(TRUE)

# UI
ui <- fluidPage(
  div(class = "container-fluid", style = "max-width: 1000px; margin: auto; padding: 20px;",
      
      titlePanel("Australian Critical Minerals Analysis"),
      
      # Introduction
      fluidRow(
        column(12,
               p(style = "font-size: 16px; margin: 20px 0px; line-height: 1.6;",
                 "In April 2025, the Australian Government announced a $1 billion expansion of the Critical Minerals Facility (CMF), bringing total capacity to $5 billion. Export Finance Australia (EFA) is evaluating how to strategically allocate these funds to enhance supply chain resilience for renewable energy technologies while supporting Australia's clean energy transition commitments."
               )
        )
      ),
      fluidRow(
        column(12,
               p(style = "font-size: 16px; margin: 20px 0px; line-height: 1.6;",
                 "This dashboard presents interactive data visualisations analysing Australia's critical minerals sector across four dimensions: export dynamics, geographic concentration, global competitive position, and environmental risks. The analysis focuses on lithium, nickel, copper, and rare earth elements; all designated as critical minerals under Australia's Critical Minerals Strategy 2023-2030."
               )
        )
      ),
      hr(),
      
      # Section 1: Export Trends
      fluidRow(
        column(12, h2("Export Trends"))
      ),
      fluidRow(
        column(12, 
               h4("Lithium, Nickel, and Copper Export Analysis"),
        )
      ),
      fluidRow(
        column(12, 
               div(style = "max-width: 700px; margin: auto;",
                   plotlyOutput("volumePlot", height = "400px")
               )
        )
      ),
      fluidRow(
        column(12, 
               div(style = "max-width: 700px; margin: auto;",
                   plotlyOutput("valuePlot", height = "400px")
               )
        )
      ),
      fluidRow(
        column(12, 
               p(HTML("<strong>Key Insight:</strong> Lithium exports surged 7.6-fold from 2016 to 2024, reaching approximately 3,500 kT and overtaking nickel around 2017, while nickel and copper volumes remained relatively stable. Meanwhile, lithium export values overtook nickel in 2021, reaching approximately $10 billion by 2025 compared to nickel's $3 billion and copper's $13 billion."))
        )
      ),
      
      hr(),
      
      # Section 2: Critical Minerals Map
      fluidRow(
        column(12, h2("Geographic Concentration"))
      ),
      fluidRow(
        column(12, 
               div(style = "max-width: 800px; margin: auto;",
                   plotlyOutput("mineralsMap", height = "600px")
               )
        )
      ),
      fluidRow(
        column(12,
               p(HTML("<strong>Key Insight:</strong> Western Australia dominates lithium and nickel production, hosting the largest operations by volume."))
        )
      ),
      
      hr(),
      
      # Section 3: Global Lithium Production
      fluidRow(
        column(12, h2("Australia's Global Competitive Position"))
      ),
      fluidRow(
        column(12, 
               div(style = "max-width: 800px; margin: auto;",
                   plotlyOutput("areaPlot", height = "600px")
               )
        )
      ),
      fluidRow(
        column(12,
               p(HTML("<strong>Key Insight:</strong> Australia overtook Chile in 2014 to become the world's largest lithium producer, reaching 88 megatonnes (37.5% of global output) by 2024."))
        )
      ),
      
      hr(),
      
      # Section 4: Mines & Protected Areas
      fluidRow(
        column(12, h2("Environmental and Social Risks"))
      ),
      fluidRow(
        column(12, 
               h4("Western Australia Mines and CAPAD Protected Areas"),
        )
      ),
      fluidRow(
        column(12, 
               div(style = "max-width: 800px; margin: auto;",
                   leafletOutput("capadMap", height = "600px")
               )
        )
      ),
      fluidRow(
        column(12,
               p(HTML("<strong>Key Insight:</strong> Eight Western Australian mines overlap with CAPAD protected areas, raising ESG concerns about biodiversity and Indigenous land rights."))
        )
      ),
      
      hr(),
      
      # Section 5: Recommendations
      fluidRow(
        column(12,
               h2("Recommendations for $1 Billion CMF Expansion Allocation"),
               
               h4("1. Support scaling of rare earths across multiple states (30% / A$300 million)"),
               p("Figure 3 demonstrates that REE production remains geographically dispersed and significantly smaller in scale compared to lithium and nickel operations. While Western Australia dominates lithium extraction, REE deposits span multiple states yet lack the capital investment needed to reach competitive production volumes. This fragmentation leaves Australia producing only a minor fraction of global REE supply despite substantial reserves. To unlock this potential, EFA should allocate approximately 30% of the CMF expansion (A$300 million) towards regional infrastructure development, such as rail, energy, and ports, which enable scaling of REE extraction and processing in states beyond Western Australia. This allocation supports SDG 9 (Industry, Innovation and Infrastructure) by developing regional processing capabilities and reducing dependence on foreign supply chains."),
               
               h4("2. Invest in downstream processing and onshoring (30% / A$300 million)"),
               p("Figures 1 and 2 together highlight Australia's performance in minerals exports, demonstrating its strong mining capability. Figure 4 reveals its dominance in primary lithium production. However these advantages do not extend to refined products required for battery manufacturing. The current export model centers on low value spodumene concentrates shipped to China for processing into the actual inputs for battery cells. This structural dependency exposes Australia to supply chain disruption risks while forfeiting the substantial value-addition that occurs downstream. Capturing greater value requires moving beyond extraction. EFA should allocate approximately 30% of CMF expansion (A$300 million) to downstream processing infrastructure, with priority given to lithium, nickel, and REE. This investment advances SDG 7 (Affordable and Clean Energy) and SDG 9 (Industry and Infrastructure) by enhancing local infrastructure that ensures a reliable supply of materials essential for the renewable energy transition."),
               
               h4("3. Prioritise infrastructure in Western Australia as the critical hub (25% / A$250 million)"),
               p("Figures 1, 3, and 4 collectively establish Western Australia's dominance across the critical minerals value chain. The state hosts Australia's largest lithium and nickel operations and accounts for the majority of production driving the country's 35% share of global lithium output. Given the concentration of critical minerals in WA, EFA should allocate approximately 25% of CMF expansion (A$250 million) to mine-adjacent infrastructure in the state including roads, ports, renewable power connections, and logistics. This promotes an economies of scale for shared infrastructure at the same time as it increases export efficiency and competitiveness, thereby supporting SDG 9 (Industry, Innovation and Infrastructure)."),
               
               h4("4. Embed ESG safeguards in all funded projects (15% / A$150 million)"),
               p("Figure 5 highlights areas of overlap between mining operations and protected zones, indicating that further expansion of critical minerals extraction may intensify pressure on ecologically sensitive zones and Indigenous lands. To align with SDG 13 (Climate Action) and broader ESG commitments, EFA should make funding conditional on environmental and social risk management. This includes prioritising projects located at safe distances from ecologically sensitive areas, supporting biodiversity offsets, and ensuring meaningful consultation with Indigenous communities. A dedicated funding stream of approximately 15% of CMF (A$150 million) should therefore be earmarked not only for ESG monitoring and rehabilitation but also for advancing data-driven mapping approaches that improve accountability over time."),
               
               br(),
               p(style = "font-style: italic;", 
                 "These recommendations aim to position Australia as a responsible, higher-value critical minerals supplier whilst reducing risks that could undermine long-term market access and partnerships with Japan, South Korea, the EU, and the United States.")
        )
      ),
      
      hr(),
      
      # Section 6: Data Sources
      fluidRow(
        column(12, h2("Data Sources"))
      ),
      fluidRow(
        column(12,
               p("This analysis draws upon four authoritative public datasets:")
        )
      ),
      fluidRow(
        column(12,
               tags$div(style = "overflow-x: auto;",
                        tags$table(class = "table table-striped table-bordered", style = "width: 100%; font-size: 14px;",
                                   tags$thead(
                                     tags$tr(
                                       tags$th("#"),
                                       tags$th("Source"),
                                       tags$th("Dataset"),
                                       tags$th("Format"),
                                       tags$th("Details")
                                     )
                                   ),
                                   tags$tbody(
                                     tags$tr(
                                       tags$td("1"),
                                       tags$td("Department of Industry, Science and Resources (DISR)"),
                                       tags$td("Resources and Energy Quarterly (June 2025, historical data)"),
                                       tags$td(".xlsx, multiple worksheets"),
                                       tags$td(HTML("Quarterly report detailing historical and forecast data on Australia's major resource and energy commodities (production, exports, prices).<br>Available at: <a href='https://www.industry.gov.au/sites/default/files/2025-06/resources-and-energy-quarterly-june-2025-historical-data.xlsx' target='_blank'>DISR Historical Data</a> (accessed 18 October 2025)."))
                                     ),
                                     tags$tr(
                                       tags$td("2"),
                                       tags$td("Energy Institute (with major processing by Our World in Data)"),
                                       tags$td("Statistical Review of World Energy (2025) – Lithium Production dataset"),
                                       tags$td(".csv"),
                                       tags$td(HTML("Global dataset showing annual lithium production by country from 1995–2024.<br>Available at: <a href='https://ourworldindata.org/grapher/lithium-production.csv?v=1&csvType=full&useColumnShortNames=true' target='_blank'>Our World in Data</a> (accessed 18 October 2025)."))
                                     ),
                                     tags$tr(
                                       tags$td("3"),
                                       tags$td("Geoscience Australia (GA)"),
                                       tags$td("Australian Operating Mines 2024"),
                                       tags$td(".csv"),
                                       tags$td(HTML("Geoscience Australia dataset mapping mine locations, commodities, and operational status across Australia as of Dec 2024.<br>Available at: <a href='https://d28rz98at9flks.cloudfront.net/150112/150112_01_0.xlsx' target='_blank'>GA Operating Mines</a> (accessed 18 October 2025)."))
                                     ),
                                     tags$tr(
                                       tags$td("4"),
                                       tags$td("Department of Climate Change, Energy, the Environment and Water (DCCEEW)"),
                                       tags$td("Collaborative Australian Protected Areas Database (CAPAD) 2024"),
                                       tags$td(".shp, .json"),
                                       tags$td(HTML("National GIS database of terrestrial and marine protected areas (to 30 Jun 2024) with area, category, and management attributes.<br>Available at: <a href='https://fed.dcceew.gov.au/datasets/ec356a872d8048459fe78fc80213dc70_0/' target='_blank'>CAPAD 2024</a> (18 October 2025)."))
                                     )
                                   )
                        )
               )
        )
      )
  )
)

# Server
server <- function(input, output, session) {
  output$volumePlot <- renderPlotly({ ggplotly(p1, tooltip = "text") })
  output$valuePlot <- renderPlotly({ ggplotly(p2, tooltip = "text") })
  output$mineralsMap <- renderPlotly({ ggplotly(minesplot, tooltip = "text") })
  output$areaPlot <- renderPlotly({ ggplotly(p_area, tooltip = "text") })
  output$capadMap <- renderLeaflet({
    leaflet() %>% addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(data = capad_wa_leaflet, fillColor = "#2D6A4F", fillOpacity = 0.5, color = "#2D6A4F", weight = 0.1, label = ~paste0(NAME, " (", TYPE, ")"), popup = ~paste0("<b>", NAME, "</b><br>Type: ", TYPE, "<br>IUCN Category: ", IUCN)) %>%
      addCircleMarkers(data = mines_with_capad, radius = 4, color = ~mine_color, fillColor = ~mine_color, fillOpacity = 0.8, stroke = TRUE, weight = 1, label = ~lapply(paste0("Mine: ", Name, "<br>Status: ", Status, "<br>Commodity Group: ", `Commodity Group`), htmltools::HTML), popup = ~paste0("<b>", Name, "</b><br>Commodity: ", `Commodity Group`, "<br>Status: ", Status)) %>%
      addLegend(position = "bottomright", colors = c("#2D6A4F", "#E66101", "#5E3C99"), labels = c("CAPAD 2024 Protected Areas", "Mines in Protected Areas (overlap)", "Mines Outside Protected Areas"), title = "Legend", opacity = 1)
  })
}

shinyApp(ui = ui, server = server)