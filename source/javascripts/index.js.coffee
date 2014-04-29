$ ->
  sort_by = (key, order="ASC")->
    articles = $(".article").sort (a, b)->
      ai = +$(a).data(key)
      bi = +$(b).data(key)
      if order == "ASC" then (ai - bi) else (bi - ai)
    container = $("#articles")
    container.fadeOut("fast", ->
      container.empty()
      container.append(articles)
    ).fadeIn("fast")

   highlight = (target)->
    $(".js-id, .js-new, .js-star").css("color", "")
    $(target).css("color", "gray")
    
  $(".js-id").click ->
    sort_by("game-id")
    highlight(@)
  
  $(".js-new").click ->
    sort_by("game-id", "DESC")
    highlight(@)

  $(".js-star").click ->
    sort_by("star", "DESC")
    highlight(@)

  $(".js-new").click()
