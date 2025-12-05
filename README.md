# Critical Minerals Interactive Analysis
**Data-Driven Investment Strategy for Australian Critical Minerals Using R (ggplot2, Plotly, Shiny)**

Interactive visualisation analysis supporting Export Finance Australia's A$1 billion Critical Minerals Facility expansion, demonstrating Australia's strategic position in global lithium supply chains whilst identifying ESG risks through spatial overlay analysis.

---

## Business Context

Export Finance Australia manages a A$1 billion expansion of the Critical Minerals Facility (announced April 2025) to strengthen Australia's role in clean energy supply chains. This analysis evaluated strategic allocation across lithium, nickel, and rare earth elements (REEs) to maximise value creation whilst mitigating environmental and social risks aligned with UN Sustainable Development Goals 7, 9, and 13.

**Problem Statement**: How should EFA strategically allocate A$1 billion to maximise Australia's contribution to global critical minerals supply chains whilst addressing biodiversity and Indigenous land rights concerns?

---

## Key Findings

### 1. Australia's Lithium Dominance (37.5% Global Production)
Interactive time series analysis revealed Australia overtook Chile as the world's largest lithium producer in 2014, reaching 88 mega tonnes (37.5% global share) by 2024. However, lithium export values only surpassed nickel in 2021, marking a strategic inflection point in Australia's mineral export composition.

**Insight**: Raw spodumene concentrate shipments to China for processing create strategic dependency and forfeit high-value downstream opportunities in lithium hydroxide and carbonate production.

### 2. Geographic Concentration in Western Australia
Spatial mapping with pan/zoom interactions showed Western Australia hosts the majority of lithium and nickel operations by production volume. REE production remains geographically dispersed across Queensland, New South Wales, and WA but at significantly smaller scales, representing untapped growth potential.

**Insight**: Infrastructure investment should prioritise WA's existing mining clusters whilst supporting REE scaling across multiple states to diversify supply chains.

### 3. ESG Risks in Protected Areas
Interactive spatial overlay of mine locations with CAPAD 2024 protected areas identified 8 operational sites in Western Australia with minor spatial overlap with conservation zones. Hover tooltips enabled precise identification of affected mines, minerals, and protected area types.

**Insight**: Unmanaged ESG risks could undermine Australia's credibility with international partners (Japan, EU, South Korea, US) implementing stricter sustainable sourcing requirements.

---

## Strategic Recommendations (A$1 Billion Allocation)

| Priority | Allocation | Rationale |
|----------|-----------|-----------|
| **REE Scaling Across States** | A$300M (30%) | Support geographically distributed REE projects with offtake agreements to reduce Chinese processing dominance |
| **Downstream Processing Infrastructure** | A$300M (30%) | Require domestic refining in offtake agreements to capture higher-value lithium hydroxide/carbonate production |
| **WA Infrastructure Hub** | A$250M (25%) | Build on existing production clusters with shared processing facilities, ports, and logistics |
| **ESG Safeguards & Monitoring** | A$150M (15%) | Mandate biodiversity assessments, Free Prior and Informed Consent protocols, and independent verification |

---

## Technical Implementation

### Interactive Visualisation Features

**Heer & Shneiderman Taxonomy Implementation**:
- **Filter**: Commodity isolation in time series (Figures 1, 2) enables focused trend analysis
- **Details-on-demand**: Tooltips reveal mine names, production volumes, protected area categories without visual clutter
- **Pan/Zoom**: Spatial exploration in maps (Figures 3, 5) enables granular inspection of Western Australian mining clusters and protected area overlaps
- **Select**: Hover interactions highlight specific data points across linked visualisations

### Grammar of Graphics (ggplot2)

**Figure 4 - Global Lithium Production (Stacked Area Chart)**:
- **Data**: Annual lithium production (mega tonnes) by country, 2004-2024
- **Layers**: `geom_area()` with white strokes for country separation; `geom_vline()` annotating Australia's 2014 overtake point
- **Scales**: Continuous y-axis (production volume); temporal x-axis; categorical colour scale
- **Coordinates**: Default Cartesian system
- **Facets**: Single panel showing all countries

**Design Rationale**: Stacked area chart follows Munzner's principle of using area marks for part-to-whole relationships. Saturated blue highlights Australia whilst muting competitors in beige/grey (Ware's selective attention principle). Annotation reduces cognitive load by directing readers to the 2014 inflection point (Tufte).

### Design Improvements from Assignment 1

**Accessibility**: Replaced blue-red-green palette with blue-red-orange to accommodate colourblind users (~8% of males). Orange encoding for mines in protected areas (Figure 5) uses colour as a risk signal (Ware, 2020).

**Data-Ink Ratio**: Simplified fiscal year labels ("1989-90" → "1990"), reduced y-axis ticks, lightened gridlines to 20% opacity (Tufte, 2001). Removed redundant chart elements whilst preserving reference structure (Few, 2012).

**Subtitles**: Added italicised subtitles communicating key findings ("Lithium exports surge by 7.6x from 2016 to 2024") following Few's guidance that titles should convey insights, not just label content.

---

## Data Sources & Methodology

### Datasets

| Source | Dataset | Details |
|--------|---------|---------|
| **Dept of Industry, Science & Resources (DISR)** | Resources and Energy Quarterly (June 2025) | Historical export volumes and values for critical minerals (1990-2024) |
| **Energy Institute** | Statistical Review of World Energy (2025) | Global lithium production by country (2004-2024) |
| **Geoscience Australia** | Australian Operating Mines 2024 | Mine locations, commodities, production volumes |
| **Dept of Climate Change (DCCEEW)** | CAPAD 2024 | Protected areas database (terrestrial/marine zones with IUCN categories) |

### Technical Challenges

**Spatial Data Processing**: CAPAD shapefiles exceeded 20MB, requiring `sf` package for polygon transformations and overlay operations. Focused on State-level data to manage processing loads whilst maintaining analytical precision.

**Interactive Conversion**: Converting static ggplot2 to Plotly introduced rendering inconsistencies - dual legends disappeared, subtitles required manual restoration via workaround code. Spatial overlays in Figure 5 resulted in 15-20 second load times due to complex geometries.

**Data Quality Limitations**: GA Operating Mines dataset omits smaller operations; some production volumes confidential for commercial reasons, requiring estimation. Spatial accuracy indicates proximity but not actual environmental impact - true ESG verification requires field assessments beyond this study's scope.

---

## Technical Skills Demonstrated

- **R Programming**: ggplot2 (Grammar of Graphics), Plotly (interactive charts), Shiny (web applications), sf (spatial analysis)
- **Data Wrangling**: Multi-format integration (CSV, Excel, shapefiles), spatial joins, temporal aggregations
- **Visualisation Theory**: Munzner's nested model, Bertin's visual variables, Tufte's data-ink principles, Ware's perceptual encodings
- **Interaction Design**: Heer & Shneiderman taxonomy implementation (filter, zoom, tooltip, select)
- **Geospatial Analysis**: Spatial overlay operations, coordinate reference systems, protected area mapping
- **Business Communication**: Executive-level recommendations, SDG alignment, strategic allocation frameworks

---

## Tools & Technologies

- **Languages**: R (ggplot2, Plotly, dplyr, sf, leaflet)
- **Frameworks**: Shiny (interactive dashboard deployment)
- **Spatial Tools**: sf package, CAPAD protected areas database, ozmaps
- **Data Processing**: readxl, tidyverse, spatial geometry validation
- **Deployment**: Shiny web application with multi-tab interface

---

## Repository Structure
```
├── 01_executive_report.pdf                         # Full analysis report (7 pages)
├── 02_interactive_dashboard_screenshot.png         # Shiny app interface
├── 03_key_visualisations/
│   ├── export_volumes_time_series.png
│   ├── global_lithium_production_stacked_area.png
│   ├── australia_mines_spatial_map.png
│   └── wa_protected_areas_overlay.png
├── shiny_app/
│   ├── app.R                                       # Deployed Shiny application
│   ├── data/                                       # Processed datasets
│   └── README.md                                   # Deployment instructions
├── r_code/
│   ├── 01_data_preparation.R                       # Data cleaning and spatial joins
│   ├── 02_ggplot2_visualisations.R                 # Static chart generation
│   └── 03_interactive_components.R                 # Plotly and Shiny interactivity
├── appendices/
│   ├── grammar_of_graphics_analysis.pdf            # ggplot2 layer breakdown and design rationale
│   └── design_evaluation.pdf                       # Munzner/Bertin/Tufte critique and improvements
└── README.md
```

---

## Key Learnings

**Spatial Data Scalability**: Large shapefiles (20MB+) require strategic subset selection and geometry simplification for interactive applications. State-level filtering balanced analytical detail with performance constraints.

**Plotly Conversion Challenges**: Direct `ggplotly()` conversion doesn't preserve all ggplot2 aesthetics. Custom tooltip formatting via `aes(text = ...)` and manual subtitle restoration required to maintain visualisation quality.

**Accessibility by Default**: Implementing colourblind-safe palettes upfront (blue-orange-purple) prevented rework and expanded audience reach without sacrificing visual effectiveness.

**Executive Communication**: Interactive features enable exploration, but strategic recommendations still require clear written synthesis. Tooltips provide depth; subtitles provide direction.

---

## Project Context

Completed as BSAN7208 (Visual Analytics) at University of Queensland, demonstrating capabilities in interactive data visualisation, spatial analysis, and executive-level strategic communication applicable to sustainability consulting and commercial analytics roles.

**Video Presentation**: 15-minute stakeholder presentation demonstrating interactive features, addressing technical challenges, and discussing future directions (available upon request).

---

**Author**: Georgy Onishi  
**Completion Date**: October 2025  
**Word Count**: 2,397 (report body); 7 pages + appendices
