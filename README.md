# Critical Minerals Interactive Analysis
**Data-Driven Investment Strategy for Australian Critical Minerals Using R (ggplot2, Plotly, Shiny)**

I created an interactive R visualisation platform to help Export Finance Australia strategically allocate A$1 billion in critical minerals funding. The analysis looks at Australia's critical minerals section across four dimensions: export dynamics, global competitive position, geographic concentration, and environmental challenges.
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

**Australia's Lithium Dominance**: Australia produces 37.5% of global lithium (88 megatonnes, 2024), overtaking Chile in 2014. However, most exports are raw spodumene concentrate shipped to China for processing, creating strategic dependency. **Recommendation**: Allocate 30% (A$300M) to downstream processing infrastructure to capture higher-value lithium hydroxide and carbonate production.

**Geographic Concentration**: Western Australia hosts the majority of lithium and nickel operations by production volume, whilst REE production remains geographically dispersed at smaller scales across Queensland, New South Wales, and WA. **Recommendation**: Allocate 30% (A$300M) to REE infrastructure across multiple states and 25% (A$250M) to WA mining cluster infrastructure (ports, logistics, renewable power).

**ESG Risks**: Spatial overlay analysis identified 8 operational mines overlapping CAPAD protected areas in Western Australia, raising concerns about biodiversity and Indigenous land rights that could undermine credibility with international partners (Japan, EU, South Korea, US). **Recommendation**: Allocate 15% (A$150M) to mandatory ESG safeguards including biodiversity assessments, Free Prior and Informed Consent protocols, and independent verification.

Refer to the [Full Report](01_executive_report.pdf) to see my  complete analysis and detailed explanation of findings and recommendations.

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

**Spatial Overlay Analysis**: I integrated three independent spatial datasets to identify ESG risks—mine coordinates (Geoscience Australia), protected area polygons (CAPAD 20MB shapefile), and Australia's base map (`rnaturalearth` package). Using the `sf` package, I performed spatial joins (`st_join` with `st_within`) to identify 8 mines overlapping conservation zones in Western Australia.

**Interactive Pipeline**: I converted static ggplot2 charts to interactive Plotly visualisations with tooltips and filtering, then deployed via Shiny. Resolved rendering issues (disappeared legends, subtitles) through custom code workarounds and optimised 20MB shapefile load times via geometry simplification.

**Data Wrangling**: I processed multi-format data (CSV, Excel, shapefiles), conducted spatial joins, standardised coordinate reference systems to WGS84, and harmonised temporal data across fiscal/calendar years (1990-2025).

**Shiny Deployment**: I deployed the application to shinyapps.io, managing dependencies across multiple R packages (ggplot2, plotly, leaflet, sf) and ensuring all datasets loaded correctly in the cloud environment. Addressed file path issues when transitioning from local development to hosted deployment and optimised reactive rendering to handle large spatial datasets without exceeding free tier memory limits.

---

## IV. Tools & Technologies

- **Languages**: R (ggplot2, Plotly, dplyr, sf, leaflet)
- **Frameworks**: Shiny (interactive dashboard deployment)
- **Spatial Tools**: sf package, CAPAD protected areas database, ozmaps
- **Data Processing**: readxl, tidyverse, spatial geometry validation
- **Deployment**: shinyapps.io (cloud hosting)

---

## V. Repository Structure
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

## VI. Project Context

Completed as BSAN7208 (Visual Analytics) at University of Queensland, demonstrating capabilities in interactive data visualisation, spatial analysis, and executive-level strategic communication applicable to sustainability consulting and commercial analytics roles.

**Author**: Georgy Onishi  
**Completion Date**: October 2025
