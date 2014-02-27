$ ->
  sort_by = (key, order="ASC")->
    articles = $(".article").sort (a, b)->
      ai = +$(a).data(key)
      bi = +$(b).data(key)
      if order == "ASC" then (ai > bi) else (ai < bi)
    container = $("#articles")
    container.fadeOut("fast", ->
      container.empty()
      container.append(articles)
    ).fadeIn("fast")
    
  $(".js-id").click ->
    sort_by("game-id")
  
  $(".js-new").click ->
    sort_by("game-id", "DESC")

  $(".js-star").click ->
    sort_by("star", "DESC")

