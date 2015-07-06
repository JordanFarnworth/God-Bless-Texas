$('.posts.index').ready ->
  $('body').css('background-color', '#858585');

$('.posts.show').ready ->
  $('body').css('background-color', '#858585');
  getComments()
  $('#submit-post-comment').on 'click', ->
    submitComment();

$('.posts.approve').ready ->
  $('body').css('background-color', '#858585');

$('.posts.new').ready ->
  $('body').css('background-color', '#858585');


getComments = ->
  post = window.location.pathname.match(/\/posts\/(\d+)/)[1]
  $.ajax "/api/v1/posts/#{post}/comments?include[]=user",
    type: 'get'
    dataType: 'json'
    success: (data) ->
      $('#posts-list').empty()
      $.each data.results, ->
        addComment(this)

submitComment = ->
  post = window.location.pathname.match(/\/posts\/(\d+)/)[1]
  $.ajax "/api/v1/posts/#{post}/comments",
    type: 'post'
    dataType: 'json'
    data:
      comment:
        message: $('#comment-to-submit').val()
        user_id: ENV.current_user
        post_id: post
    success: (data) ->
      getComments()
      $('#comment-to-submit').val("")

addComment = (data) ->
  data.created_at = new Date(data.created_at).toLocaleDateString()
  template = Handlebars.compile($('script#post-comments').html())
  temp = $(template(data))
  $('#posts-list').append(temp)
