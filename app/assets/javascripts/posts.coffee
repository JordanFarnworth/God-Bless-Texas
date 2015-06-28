# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$('.posts.index').ready ->
  $('body').css('background-color', '#FF9900');
  $('footer').css('background-color', '#404040');
  $windows = $('.window')
  $('.window').windows
  snapping: true
  snapSpeed: 500
  snapInterval: 1100
  onScroll: (scrollPos) ->
    # scrollPos:Number
    return
  onSnapComplete: ($el) ->
    # after window ($el) snaps into place
    return
  onWindowEnter: ($el) ->
    # when new window ($el) enters viewport
    return
