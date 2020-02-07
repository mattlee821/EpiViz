<div class="well well-lg">
<h3>Step 1: data preperation</h3>
<p align="justify">Your data needs to formatted before using <strong>MR Viz</strong></p>
</div>

<p align="justify">You should format your data based on the number of tracks you want on teh Circos plot. Each track requires an individual data frame. Each of these data frames should be identical in the number of rows and associated labels and groups used. Use the example data on the <i>Home</i> tab as a guide.</p>

<h4>Your data should look like this:</h4>
<table style="width:100%">
<tr>
<th>label</th>
<th>group</th>
<th>effect estimate</th>
<th>p-value</th>
<th>lower_ci</th>
<th>upper_ci</th>
</tr>
<tr>
<td>label1</td>
<td>group1</td>
<td>0.1</td>
<td>0.001</td>
<td>0.08</td>
<td>0.12</td>
</tr>
<tr>
<td>label2</td>
<td>group2</td>
<td>0.1</td>
<td>0.001</td>
<td>0.08</td>
<td>0.12</td>
</tr>
<tr>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
</table>

<br>

<h4>Notes</h4>
<p align="justify">The label will be plotted around the outside of the Circos plot. The group column is needed to make the Circos plot, but it can be the same for all rows of your data frame if your data isn't groupable- just add a column with the same variable (e.g. 'group1') for all of your rows. You can have as many groups as you want. The effect estimate can be any type: beta, Z-score, OR etc. CI = confidence interval.</p>
    
<p align="justify">Your data should be saves as a <code>tab</code> seperated <code>.txt</code> file. We recommend using the following <code>R</code> code to save your data-frame:</p>
    
<pre><code>write.table(data, "/path/to/your/directory/data_frame.txt", 
row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
</code></pre>