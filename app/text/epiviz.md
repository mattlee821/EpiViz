<html>
<style>
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: Arial;
}

.header {
  text-align: center;
  padding: 32px;
}

.row {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  padding: 0 4px;
}

/* Create four equal columns that sits next to each other */
.column {
  -ms-flex: 25%; /* IE10 */
  flex: 25%;
  max-width: 25%;
  padding: 0 4px;
}

.column img {
  margin-top: 8px;
  vertical-align: middle;
  width: 100%;
}

/* Responsive layout - makes a two column-layout instead of four columns */
@media screen and (max-width: 800px) {
  .column {
    -ms-flex: 50%;
    flex: 50%;
    max-width: 50%;
  }
}

/* Responsive layout - makes the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .column {
    -ms-flex: 100%;
    flex: 100%;
    max-width: 100%;
  }
}

</style>
<body>



<!-- Header -->
<img src = "../www/epiviz_banner.png"
     style = "width:100%"
     alt = "example circos plot 1">

<!-- Photo Grid -->
<div class="row"> 

  <!-- Column 1 -->
  <div class="column">
  
  <a href = "https://github.com/mattlee821/EpiCircos" target = "_blank">
	<img src="../www/gallery/epiviz_example_group.png"
  alt="Circos plot example" 
  style="width:100%">
  </a>
  
  </div>
  
  <!-- Column 2 -->
  <div class="column">
  <a href = "https://github.com/mattlee821/EpiCircos" target = "_blank">
	<img src="../www/gallery/epiviz_example_subgroup.png"
  alt="" 
  style="width:100%">
  </a>
  </div> 
  
  <!-- Column 3 -->
  <div class="column">
  <a href = "https://github.com/mattlee821/EpiCircos" target = "_blank">
  <img src="../www/gallery/circos_example1.png"
  alt="example 1" 
  style="width:100%">
  </a>
  </div> 
  
  <!-- Column 4 -->
  <div class="column">
  <a href = "https://github.com/mattlee821/EpiCircos" target = "_blank">
  <img src="../www/gallery/circos_example2.png"
  alt="" 
  style="width:100%">
  </a>
  </div> 
</div>

</body>
</html>
