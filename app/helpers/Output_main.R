epiviz = function(){
  list(
    div(
      id = "epiviz",
      includeMarkdown(file.path("text", "epiviz.md"))
    )
  )
}

home_home = function(){
  list(
    div(
      id = "home_home",
      includeMarkdown(file.path("text", "home_home.md"))
    )
  )
}

home_about = function(){
  list(
    div(
      id = "home_about",
      includeMarkdown(file.path("text", "home_about.md"))
    )
  )
}

home_example = function(){
  list(
    div(
      id = "home_example",
      includeMarkdown(file.path("text", "home_example.md")),
      downloadButton("downloadexampledata1", "Sex combined results"),
      downloadButton("downloadexampledata2", "Male results"),
      downloadButton("downloadexampledata3", "Female results"),
      )
    )
}

home_footer = function(){
  list(
    div(
      id = "home_footer",
      includeMarkdown(file.path("text", "home_footer.md"))
    )
  )
}

how_to_1 = function(){
  list(
    div(
      id = "how_to_1",
      includeMarkdown(file.path("text", "how_to_1.md"))
    )
  )
}

how_to_2 = function(){
  list(
    div(
      id = "how_to_2",
      includeMarkdown(file.path("text", "how_to_2.md"))
    )
  )
}

how_to_3 = function(){
  list(
    div(
      id = "how_to_3",
      includeMarkdown(file.path("text", "how_to_3.md"))
    )
  )
}

about_about = function(){
  list(
    div(
      id = "about_about",
      includeMarkdown(file.path("text", "about_about.md"))
    )
  )
}

about_acknowledgements = function(){
  list(
    div(
      id = "about_acknowledgements",
      includeMarkdown(file.path("text", "about_acknowledgements.md"))
    )
  )
}

about_updates = function(){
  list(
    div(
      id = "about_updates",
      includeMarkdown(file.path("text", "about_updates.md"))
    )
  )
}


