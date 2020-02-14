<div class="well well-lg">
<h3>Step 1: data preperation</h3>
<p align="justify">Fromatting your data before using <strong>EpiViz</strong></p>
</div>

<p align="justify">Each track of the Circos plot requires an individual data frame. Each of these data frames should be identical in the number of rows and associated labels and groups used. Use the example data on the <i>Home</i> tab as a guide.</p>

<p align="justify">
Your data should be tab separated and have the following columns:
<ul>
  <li>label</li>
  <li>effect estimate</li>
  <li>p-value</li>
  <li>lower confidence interval</li>
  <li>upper confidence interval</li>
  <li>group</li>
</ul>
</p>
<p align="justify"> <strong>NB:</strong> if the p-value column is the third column in your data frame a volcano plot will be automatically produced when you upload your data. </p>

<p align="justify">Your data should be saved as a <code>tab</code> seperated <code>.txt</code> file. We recommend using the following <code>R</code> code to save your data-frame:</p>
    
<pre><code>write.table(data, "/path/to/your/directory/data_frame.txt", 
row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
</code></pre>

<br>

<h4>Notes</h4>
<p align="justify">
<ul>
  <li>Labels are plotted around the outside of the Circos plot</li>
  <li>The group column is needed to make the Circos plot, but it can be the same for all rows of your data frame if you dont have groups </li>
  <li> You can have as many groups as you want</li>
</ul>
