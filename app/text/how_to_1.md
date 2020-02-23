<div class="well well-lg">
<h3>Step 1: data preperation</h3>
<p align="justify">Fromatting your data before using <strong>EpiViz</strong></p>
</div>

<p align="justify">Each track of the Circos plot requires an individual data frame. Each of these data frames should be identical in the number of rows and associated labels and groups used. Use the example data on the <i>Home</i> tab as a guide.</p>

<h4>Content of data frame</h4>
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

<h4>Saving data frame</h4>
<p align="justify">Your data should be saved as a <code>tab</code> seperated <code>.txt</code> file. We recommend using the following <code>R</code> code to save your data-frame:</p>
    
<pre><code>write.table(data, "/path/to/your/directory/data_frame.txt", 
row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
</code></pre>

<br>

<h4>Notes</h4>
<p align="justify">
<strong>Labels</strong> are plotted around the outside of the plot. If the <strong>p-value</strong> column is the third column a volcano plot will be automatically produced when uplaoding your data. Your data frame can contain <strong>extra columns</strong> than are required, but the application will only work with the required columns. Additional columns will be ignored.</p>

<p align="justify">
The <strong>group</strong> column is needed to make the Circos plot. If your data doesn't use groups, or you haven't started grouping your data (see Step 3), assign a single group to all of your data points and they will be plotted in a single group. You can have as many groups as you want. Each group has a border of empty space so the more groups you have the less space for your data points. See step 3 for more info on grouping ideas. </p>

