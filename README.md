# Critical Minerals Interactive Analysis
**Data-Driven Investment Strategy for Australian Critical Minerals Using R (ggplot2, Plotly, Shiny)**

I created an interactive R visualisation platform to help Export Finance Australia strategically allocate A$1 billion in critical minerals funding. The analysis looks at Australia's critical minerals section across four dimensions: export dynamics, global competitive position, geographic concentration, and environmental challenges.

### 🔗 Live Interactive Dashboard (Shiny): https://c7cq5t-george-onishi.shinyapps.io/shiny_deployment/

## 1. Business Context

This project builds an interactive R platform to guide strategic investment across lithium, nickel, and rare earths.  
Key outputs:
- Interactive Shiny dashboard with commodity filtering and spatial overlays  
- Spatial ESG risk detection via `sf` (8 mines overlapping protected areas)
- Time-series analysis of export trends (1990–2024)  
- Comparative global production analysis for lithium (2004–2024)  

## 2. Key Findings

- Lithium: Australia leads global output but remains dependent on offshore processing → prioritise downstream capacity.
- Nickel: High concentration in WA → invest in regional infrastructure.
- REEs: More geographically distributed → multi-state investment.
- ESG: Spatial overlay reveals conservation-area exposure → fund safeguards and verification.

Refer to the [Full Report](01_executive_report.pdf) to see my complete analysis, findings, and recommendations.

## 3. Data Sources & Methodology

### Technical Highlights

- Spatial analysis using `sf` (`st_join`, `st_within`)
- Time-series modelling of export dynamics
- Geometry simplification to optimise Shiny load times
- Plotly conversion for interactive charts
- Full deployment pipeline to shinyapps.io with dependency management

### Datasets

| Source | Dataset | Details |
|--------|---------|---------|
| **Dept of Industry, Science & Resources (DISR)** | [Resources and Energy Quarterly (June 2025)](raw_datasets/resources-and-energy-quarterly-june-2025-historical-data.xlsx) | Historical export volumes and values for critical minerals (1990-2024) |
| **Energy Institute** | [Statistical Review of World Energy (2025)](raw_datasets/lithium-production.csv) | Global lithium production by country (2004-2024) |
| **Geoscience Australia** | [Australian Operating Mines 2024](raw_datasets/Australian_Operating_Mines_2024_2.xlsx) | Mine locations, commodities, production volumes |
| **Dept of Climate Change (DCCEEW)** | [CAPAD 2024](https://www.dcceew.gov.au/environment/land/nrs/science/capad/2024) | Protected areas database (terrestrial/marine zones with IUCN categories) |

## 4. Tools & Technologies

- **Languages**: R (ggplot2, Plotly, dplyr, sf, leaflet)
- **Frameworks**: Shiny (interactive dashboard deployment)
- **Spatial Tools**: sf package, CAPAD protected areas database, ozmaps
- **Data Processing**: readxl, tidyverse, spatial geometry validation
- **Deployment**: shinyapps.io (cloud hosting)

## 5. Repository Structure
```
├── 01_executive_report.pdf                                            # Full analysis report
├── 02_ggplot2_visualisations.R                                        # Static chart generation with Grammar of Graphics
├── 03_interactive_shiny_app.R                                         # Deployed Shiny application code
├── visualisations/                                                    # PNG exports of key charts
│   ├── australia_mines_spatial_map.png
│   ├── export_values_time_series.png
│   ├── export_volumes_time_series.png
│   ├── global_lithium_production_stacked_area.png
│   └── wa_protected_areas_overlay.png
├── raw_datasets/                                                      # Source data files
│   ├── Aus DIS resources-and-energy-quarterly-june-2025-forecast-data.xlsx
│   ├── Aus DIS resources-and-energy-quarterly-june-2025-historical-data.xlsx
│   ├── GA Australian_Operating_Mines_2024_2.xlsx
│   └── lithium-production.csv
└── README.md
```

---

## 6. Project Context

Completed as BSAN7208 (Visual Analytics) at University of Queensland, demonstrating capabilities in interactive data visualisation, spatial analysis, and executive-level strategic communication applicable to sustainability consulting and commercial analytics roles.

**Author**: Georgy Onishi  
**Completion Date**: October 2025
