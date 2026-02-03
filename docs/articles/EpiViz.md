# Introduction to EpiViz

## `EpiViz`: Circos plots for epidemiologists

Circos plots enable the visualization of large amounts of data in a
compact, circular format. However, they can be complex to produce using
low-level graphics engines. `EpiViz` streamlines this process for common
epidemiological data structures, such as metabolite association studies
or multi-exposure GWAS results.

### Why use EpiViz?

1.  **Efficiency**: Reduce hundreds of lines of `circlize` code to a
    single function call.
2.  **Standardization**: Enforce consistent grouping and scaling across
    circular sectors.
3.  **Professional Quality**: Automatically generates legends using
    `ComplexHeatmap` for publication-ready figures.

### Installation

You can install the development version of EpiViz from GitHub:

``` r

# install.packages("devtools")
devtools::install_github("mattlee821/EpiViz/R_package")
```

### Core Elements of an EpiViz Plot

To understand how EpiViz constructs its visualizations, refer to the
annotated guide below:

![](../figures/annotated_circos_plot2.png)

- **Sectors**: Segments of the circle defined by a grouping variable
  (e.g., metabolite class).
- **Tracks**: Rings within the circle where data is plotted (Points,
  Lines, Bars, or Histograms).
- **Labels**: Variable names plotted on the outer edge.
- **Legend**: Explanatory key for track colors and significance
  indicators.

For detailed usage, see the [R Package
Examples](https://mattlee821.github.io/EpiViz/articles/examples.md)
guide.
