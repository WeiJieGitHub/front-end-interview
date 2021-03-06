do ->
  CustomEvent = (event, params) ->
    params = params or
      bubbles: false
      cancelable: false
      detail: undefined
    evt = document.createEvent('CustomEvent')
    evt.initCustomEvent event, params.bubbles, params.cancelable, params.detail
    evt

  if typeof window.CustomEvent == 'function'
    return false
  CustomEvent.prototype = window.Event.prototype
  window.CustomEvent = CustomEvent
  return