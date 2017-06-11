# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# = require ./polyfills/custom_event.coffee
# = require ./components/modal.coffee

eventList = [
  'modal:init'
  'modal:remove'
  'modal:beforeOpen'
  'modal:opening'
  'modal:afterOpen'
  'modal:beforeClose'
  'modal:closing'
  'modal:afterClose'
]
eventList.forEach (event) ->
  document.body.addEventListener event, (e) ->
    console.log e.type

modal = new MyModal '#modal'

document.getElementById('open').onclick = ->
  modal.open()

document.getElementById('close').onclick = ->
  modal.close()
