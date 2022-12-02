<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
  box-sizing: border-box;
}

/* Create three equal columns that floats next to each other */
.column {
  float: left;
  width: 33.33%;
  padding: 10px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - makes the three columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .column {
    width: 100%;
  }
}
</style>
</head>
<body>

<div class="row">

  <div class="column">
    <h1>News</h1>
    <h3>2019-09-20</h3>
    <p align="justify"> 
    App launched!
    </p>
  </div>
  
  <div class="column">
    <h1>Updates</h1>
  </div>
  
  <div class="column">
    <h1>To do...</h1>
  </div>
  
</div>

</body>
</html>



