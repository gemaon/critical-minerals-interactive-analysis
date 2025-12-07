# Critical Minerals Interactive Analysis
**Data-Driven Investment Strategy for Australian Critical Minerals Using R (ggplot2, Plotly, Shiny)**

I created an interactive R visualisation platform to help Export Finance Australia strategically allocate A$1 billion in critical minerals funding by analysing Australia's lithium dominance, geographic concentration risks, and environmental challenges through spatial data overlay techniques.

---

## I. Business Context

Export Finance Australia manages a A$1 billion expansion of the Critical Minerals Facility (announced April 2025) to strengthen Australia's role in clean energy supply chains. This analysis evaluated strategic allocation across lithium, nickel, and rare earth elements (REEs) to maximise value creation whilst mitigating environmental and social risks aligned with UN Sustainable Development Goals 7, 9, and 13.

**Problem Statement**: How should EFA strategically allocate A$1 billion to maximise Australia's contribution to global critical minerals supply chains whilst addressing biodiversity and Indigenous land rights concerns?

---

### 🔗 Live Interactive Dashboard

**Access the full Shiny application**: https://c7cq5t-george-onishi.shinyapps.io/shiny_deployment/

Features include pan/zoom spatial maps, commodity filtering, tooltip-based details-on-demand, and downloadable data tables showing mines overlapping protected areas.

---

## II. Key Findings

1. Australia's Lithium Dominance (37.5% Global Production)

2. Geographic Concentration in Western Australia

3. ESG Risks in Protected Areas

---

## III. Data Sources & Methodology

### Datasets

| Source | Dataset | Details |
|--------|---------|---------|
| **Dept of Industry, Science & Resources (DISR)** | [Resources and Energy Quarterly (June 2025)](raw_datasets/resources-and-energy-quarterly-june-2025-historical-data.xlsx) | Historical export volumes and values for critical minerals (1990-2024) |
| **Energy Institute** | [Statistical Review of World Energy (2025)](raw_datasets/lithium-production.csv) | Global lithium production by country (2004-2024) |
| **Geoscience Australia** | [Australian Operating Mines 2024](raw_datasets/Australian_Operating_Mines_2024_2.xlsx) | Mine locations, commodities, production volumes |
| **Dept of Climate Change (DCCEEW)** | [CAPAD 2024](https://www.dcceew.gov.au/environment/land/nrs/science/capad/2024) | Protected areas database (terrestrial/marine zones with IUCN categories) |

### Technical Challenges

- **Spatial Data Processing**: CAPAD shapefiles exceeded 20MB, requiring `sf` package for polygon transformations and overlay operations. Focused on State-level data to manage processing loads whilst maintaining analytical precision.

- **Interactive Conversion**: Converting static ggplot2 to Plotly introduced rendering inconsistencies - dual legends disappeared, subtitles required manual restoration via workaround code. Spatial overlays in Figure 5 resulted in 15-20 second load times due to complex geometries.

- **Data Quality Limitations**: GA Operating Mines dataset omits smaller operations; some production volumes confidential for commercial reasons, requiring estimation. Spatial accuracy indicates proximity but not actual environmental impact - true ESG verification requires field assessments beyond this study's scope.

---

## IV. Technical Skills Demonstrated

- **R Programming**: ggplot2 (Grammar of Graphics), Plotly (interactive charts), Shiny (web applications), sf (spatial analysis)
- **Data Wrangling**: Multi-format integration (CSV, Excel, shapefiles), spatial joins, temporal aggregations
- **Visualisation Theory**: Munzner's nested model, Bertin's visual variables, Tufte's data-ink principles, Ware's perceptual encodings
- **Interaction Design**: Heer & Shneiderman taxonomy implementation (filter, zoom, tooltip, select)
- **Geospatial Analysis**: Spatial overlay operations, coordinate reference systems, protected area mapping
- **Business Communication**: Executive-level recommendations, SDG alignment, strategic allocation frameworks

---

## V. Tools & Technologies

- **Languages**: R (ggplot2, Plotly, dplyr, sf, leaflet)
- **Frameworks**: Shiny (interactive dashboard deployment)
- **Spatial Tools**: sf package, CAPAD protected areas database, ozmaps
- **Data Processing**: readxl, tidyverse, spatial geometry validation
- **Deployment**: shinyapps.io (cloud hosting)

---

## VI. Repository Structure
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

## VII. Project Context

Completed as BSAN7208 (Visual Analytics) at University of Queensland, demonstrating capabilities in interactive data visualisation, spatial analysis, and executive-level strategic communication applicable to sustainability consulting and commercial analytics roles.

**Author**: Georgy Onishi  
**Completion Date**: October 2025
