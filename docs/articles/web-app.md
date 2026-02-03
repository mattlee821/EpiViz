# EpiViz Web Application

## Introduction to the EpiViz Web App

The **EpiViz Web Application** is designed for researchers with little
to no experience in R who want to create professional-grade Circos plots
for epidemiological data.

You can access the hosted version here: [EpiViz Web
App](https://mattlee.shinyapps.io/EpiViz/)

### Key Features

- **Upload your own data**: Supports up to 3 tracks of data in
  standardized formats.
- **Interactive Configuration**: Select columns for labels, estimates,
  p-values, and confidence intervals directly from the UI.
- **Customizable Aesthetics**: Adjust circle size, track heights, and
  color palettes.
- **Export Options**: Download high-quality PDF versions of your plots.

### How to use the Web App

#### 1. Data Preparation

Your data should be in a tabular format (CSV or TXT) and include: - A
**Label** column (e.g., metabolite names). - A **Section** column (to
group variables into sectors). - Numerical columns for **Estimates**,
**P-values**, and **Confidence Intervals**.

#### 2. Uploading

Use the file upload widgets on the sidebar to upload your primary
(Track 1) and optional additional tracks.

#### 3. Plotting

Once configured, click the **“Plot”** button. The application will
generate the Circos plot using the same robust engine as the R package.

### Troubleshooting

If you encounter issues with labels overlapping, try increasing the
**Circle Size** in the parameters panel. For very large datasets, ensure
that the number of variables per section is balanced for better
readability.
