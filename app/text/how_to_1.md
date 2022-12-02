<div class="well well-lg">
<h3>Step 1: data preparation</h3>
</div>

<p align="justify">
Each track of the Circos plot requires an individual data frame. Each of these data frames should be identical in the number of rows and associated labels and groups used. Use the example data tab as a guide.
</p>

<p align="justify">
Your data should be tab separated and have the following columns:

<ul>
  <li>label (character)</li>
  <li>effect estimate (numeric)</li>
  <li>p-value (numeric)</li>
  <li>lower confidence interval (numeric)</li>
  <li>upper confidence interval (numeric)</li>
  <li>group (factor)</li>
</ul>
</p>

<p align="justify">
For best results save data as a <code>tab</code> seperated <code>.txt</code> file. We recommend using the following <code>R</code> code to save your data-frame:
</p> 

<pre><code>write.table(data, "/path/to/your/directory/data_frame.txt", 
row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
</code></pre>
