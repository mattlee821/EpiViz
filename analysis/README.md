
# Analysis

To demonstrate the application of Circos plots in comparing and gaining
global overview of epidemiological analysis we aimed to investigate the
associations between adiposity measures and nuclear magnetic resonance
derived metabolites using Mendelian randomization. All analyses were
performed using R version 4.1.210 and the TwoSampleMR (version 0.4.22)
package11 in R. All code, results, and publicly available data are
available in this repository.

## Data

### Adiposity

We used two measures of adiposity: body mass index (BMI) and waist hip
ratio (WHR). Summary statistics were available from [Pulit et al.,
(2020)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6298238/).
Sex-combined and sex-specific summary statistics were used for all
measures.

### Metabolites

Summary statistics for 123 nuclear magnetic resonance derived
metabolites were obtained from [Kettunen et al.,
(2016)](https://www.nature.com/articles/ncomms11122). Only sex-combined
data were available.

## Statistical analysis

Genetic variants were extracted from each outcome GWAS and, where these
were not present, proxy SNPs were included if LD was ≥ 0.8. For proxy
SNPs, the inclusion of SNPs where the reference strand was ambiguous
(strand flips) was allowed and the reference strand was inferred using a
minor allele frequency (MAF) threshold. That is, the reference strand
was inferred using a MAF, so long as that MAF was not ≥ 0.3, in which
case it was excluded. Exposure and outcome summary statistics for each
of the exposure-related SNPs were harmonised in reference to the
exposure effect allele being on the increasing scale. For included
alleles where the reference strand was ambiguous, the positive strand
was inferred using effect allele frequency. That is, if the effect
allele frequency of a SNP was not ≥ 0.3 or ≤ 0.7, the reference strand
was inferred using the effect allele frequency to harmonise exposure and
outcome data; otherwise, it was removed.

An inverse variance weighted (IVW), multiplicative random effects
(IVW-MRE) model was used to estimate the effect of each exposure on the
outcome. The model assumes that the strength of the association of the
genetic instruments with the exposure is not correlated with the
magnitude of the pleiotropic effects and that the pleiotropic effects
have an average value of zero.

### Sensitivity analysis

For completeness, sensitivity analyses were performed but are not
discussed as part of the demonstration of EpiViz. Three sensitivity
models were run in parallel with the IVW-MRE model: MR-Egger, weighted
median, and weighted mode based estimators. These methods are sensitive
to the effects of potential pleiotropy. No p-value threshold
requirements were set for these methods, instead consistency between the
IVW-MRE model and these methods was investigated. A “leave-one-out”
sensitivity analysis, whereby an MR analysis where each SNP is
sequentially left out and the causal effect estimated absent of that
SNP, was performed using the IVW model. If the estimated effect is
substantially altered after the removal of a single-SNP, this may imply
that SNP is driving the association between the exposure and outcome,
which may be indicative of a pleiotropic effect of that SNP. Finally,
each of these sensitivity analyses were visualised using funnel plots
and forest plots of the single-SNP and leave-one-out MR analyses to
identify potential pleiotropic effects.

## Results

All exposure and outcome data, along with all results and figures are
available in
[`results`](https://github.com/mattlee821/EpiViz/tree/master/analysis/results).
Here, focus is given to the IVW-MRE results and comparison across and
between the sex-combined and sex-specific results for BMI and WHR.
Specifically, we use metabolite sub-classes to visually compare results.

In the first Figure, comparing the association between BMI and
metabolites across sex-combined and sex-specific instruments. Broadly,
the BMI-metabolite profile (i.e., the overall picture of association) is
similar across the three analyses. There is also broad consistency
within metabolite sub-classes; for instance, metabolites in the subclass
Small VLDL (24) are all increased by BMI across sex-combined and
sex-specific analyses. We see a similar picture when investigating the
association between WHr and metabolites across sex-combined and
sex-specific instruments (Figure 2).

<div class="figure" style="text-align: center">

<img src="results/figures/circos_bmi.svg" alt="Association between body mass index using sex-combined and sex-specific instruments with 123 metabolites. Inverse variance weighted multiplicative random effects model shown alongside 95% confidence interval" width="200%" />
<p class="caption">
Association between body mass index using sex-combined and sex-specific
instruments with 123 metabolites. Inverse variance weighted
multiplicative random effects model shown alongside 95% confidence
interval
</p>

</div>

<div class="figure" style="text-align: center">

<img src="results/figures/circos_whr.svg" alt="Association between waist hip ratio using sex-combined and sex-specific instruments with 123 metabolites. Inverse variance weighted multiplicative random effects model shown alongside 95% confidence interval" width="200%" />
<p class="caption">
Association between waist hip ratio using sex-combined and sex-specific
instruments with 123 metabolites. Inverse variance weighted
multiplicative random effects model shown alongside 95% confidence
interval
</p>

</div>

When comparing results of the association between BMI and metabolites
and WHR and metabolites using sex-combined data we see very similar
results (Figure 3). Directions of effect and effect sizes are broadly
consistent, though confidence intervals are wider for the WHR analysis.
Again, we see that the direction of effect within a sub-class (e.g.,
Very Small VLDL) is mostly in the same directoon across all sub-classes.

<div class="figure" style="text-align: center">

<img src="results/figures/circos_bmi_whr_combined.svg" alt="Association between body mass index and waist hip ratio using sex-combined instruments with 123 metabolites. Inverse variance weighted multiplicative random effects model shown alongside 95% confidence interval" width="200%" />
<p class="caption">
Association between body mass index and waist hip ratio using
sex-combined instruments with 123 metabolites. Inverse variance weighted
multiplicative random effects model shown alongside 95% confidence
interval
</p>

</div>
