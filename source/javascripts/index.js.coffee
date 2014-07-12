class Articles
  constructor: ->
    @origins = $("#articles").children()
    
  sort_by: (key, order="ASC")->
    articles = @origins.sort (a, b)->
      ai = +$(a).data(key)
      bi = +$(b).data(key)
      if order == "ASC" then (ai - bi) else (bi - ai)
    @_replace(articles)

  filter_by: (tag_name)->
    articles = @origins.filter ->
      $(@).data("tag").match(tag_name)
    @_replace(articles)

  _replace: (articles)->
    container = $("#articles")
    container.fadeOut("fast", ->
      container.empty()
      container.append(articles)
    ).fadeIn("fast")


$ ->
  window.articles = new Articles()
  
  $("#sort").children().click ->
    $("#sort").children().removeClass("js-selected")
    $(@).addClass("js-selected")
        
  $(".js-id").click   -> articles.sort_by("game-id")
  $(".js-new").click  -> articles.sort_by("game-id", "DESC")
  $(".js-star").click -> articles.sort_by("star", "DESC")

  $(".js-wiiu").click             -> articles.filter_by("WiiU")
  $(".js-ps3").click              -> articles.filter_by("PS3")
  $(".js-vita").click             -> articles.filter_by("Vita")
  $(".js-3ds").click              -> articles.filter_by("3DS")
  $(".js-android-or-ios").click   -> articles.filter_by(/Android|iOS/)
  $(".js-psp").click              -> articles.filter_by("PSP")
  $(".js-ps").click               -> articles.filter_by(/PS$/)


  # 初期状態
  $(".js-new").click()
