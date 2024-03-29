$('.login.index').ready ->
  $('body').css('background-color', '#858585');
  $('.navbar').hide()

$('.users.new').ready ->
  $('body').css('background-color', '#858585');
  $('.navbar').hide()

$('.dashboard.index').ready ->
  $('body').css('background-color', '#858585');
  getPosts()

$('.dashboard.help').ready ->
  $('body').css('background-color', '#858585');

getPosts = ->
   $.ajax "/api/v1/posts?include[]=dashboard",
   type: 'get'
   dataType: 'json'
   success: (data) ->
     console.log(data.results)
     $.each data.results, ->
       renderPopular(this)
       renderNew(this)
       renderFavorites(this)

renderPopular = (data) ->
  data.created_at = new Date(data.created_at).toLocaleDateString()
  template = Handlebars.compile($('script#favorite-posts').html())
  temp = $(template(data))
  $('#favorites').append(temp)

renderNew = (data) ->
  data.created_at = new Date(data.created_at).toLocaleDateString()
  template = Handlebars.compile($('script#new-posts').html())
  temp = $(template(data))
  $('#new').append(temp)

renderFavorites = (data) ->
  data.created_at = new Date(data.created_at).toLocaleDateString()
  template = Handlebars.compile($('script#popular-posts').html())
  temp = $(template(data))
  $('#popular').append(temp)
