# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$('.login.index').ready ->
  $('.navbar').hide()


$('.users.new').ready ->
  $('.navbar').hide()


$('.dashboard.index').ready ->
  getPosts()

getPosts = ->
   $.ajax "/api/v1/posts",
   type: 'get'
   dataType: 'json'
   success: (data) ->
     console.log(data.results)
     $.each data.results, ->
       renderPopular(this)
       renderNew(this)
       renderFavorites(this)

renderPopular = (data) ->
  template = Handlebars.compile($('script#favorite-posts').html())
  temp = $(template(data))
  $('#favorites').append(temp)

renderNew = (data) ->
  template = Handlebars.compile($('script#new-posts').html())
  temp = $(template(data))
  $('#new').append(temp)

renderFavorites = (data) ->
  template = Handlebars.compile($('script#popular-posts').html())
  temp = $(template(data))
  $('#popular').append(temp)
