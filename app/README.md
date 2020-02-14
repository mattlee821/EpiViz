
# [`EpiViz`](https://mattlee.shinyapps.io/EpiViz/): web application

The [`EpiViz`](https://mattlee.shinyapps.io/EpiViz/) application enables
users to create efficient Circos plots for a range of data common to
epidemiology. <br>

The functionality of the web application is limited to:

  - Point estimate and confidence interval
  - P-value signified by solid colour
  - P-value threshold selection
  - Legend - automatically populated by group
  - Two colour themes

For additional features use the [`R`
package](https://github.com/mattlee821/EpiViz/tree/master/R_package)

## How to

### Step 1: data preparation

Example data is provided with on the *Home* tab of the web application
and [here](https://github.com/mattlee821/EpiViz/tree/master/app). When
using your own data, your data frame needs to include:

  - label column
  - effect estimate column
  - p-value column
  - lower confidence interval column
  - upper confidence interval column
  - section column

<table>

<thead>

<tr>

<th style="text-align:left;">

label

</th>

<th style="text-align:right;">

effect\_extimate

</th>

<th style="text-align:right;">

p\_value

</th>

<th style="text-align:right;">

lower\_confidence\_interval

</th>

<th style="text-align:right;">

upper\_confidence\_interval

</th>

<th style="text-align:left;">

group

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

label1

</td>

<td style="text-align:right;">

0.11

</td>

<td style="text-align:right;">

0.01

</td>

<td style="text-align:right;">

0.10

</td>

<td style="text-align:right;">

0.12

</td>

<td style="text-align:left;">

Group1

</td>

</tr>

<tr>

<td style="text-align:left;">

label2

</td>

<td style="text-align:right;">

0.12

</td>

<td style="text-align:right;">

0.02

</td>

<td style="text-align:right;">

0.11

</td>

<td style="text-align:right;">

0.13

</td>

<td style="text-align:left;">

Group1

</td>

</tr>

<tr>

<td style="text-align:left;">

label3

</td>

<td style="text-align:right;">

0.13

</td>

<td style="text-align:right;">

0.03

</td>

<td style="text-align:right;">

0.12

</td>

<td style="text-align:right;">

0.14

</td>

<td style="text-align:left;">

Group2

</td>

</tr>

<tr>

<td style="text-align:left;">

label4

</td>

<td style="text-align:right;">

0.14

</td>

<td style="text-align:right;">

0.04

</td>

<td style="text-align:right;">

0.13

</td>

<td style="text-align:right;">

0.15

</td>

<td style="text-align:left;">

Group3

</td>

</tr>

<tr>

<td style="text-align:left;">

label5

</td>

<td style="text-align:right;">

0.15

</td>

<td style="text-align:right;">

0.05

</td>

<td style="text-align:right;">

0.14

</td>

<td style="text-align:right;">

0.16

</td>

<td style="text-align:left;">

Group3

</td>

</tr>

</tbody>

</table>

#### Grouping

### Step 2: plotting

### Step 3: next steps
