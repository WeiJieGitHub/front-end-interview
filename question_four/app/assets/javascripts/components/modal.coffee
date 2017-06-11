# 构造器
Modal = (query) ->
  if !this instanceof Modal
    return new Modal(query)
  el = document.querySelector(query)
  if el != null
    @el = el
  else
    throw new TypeError(query + ' not found')
  for index of Modal._initCallBacks
    Modal._initCallBacks[index].apply this, arguments
  return

# 初始化事件函数
Modal._initEvent = ->
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
  eventList.forEach ((eventName) ->
    @addEvent eventName
  ).bind(this)

# 自定义事件
Modal.addEvent = (eventName, params) ->
  Modal._events = Modal._events or {}
  customEventInit = 
    bubbles: true
    cancelable: true
    detail: this
  for key of params
    if Object::hasOwnProperty.call(params, key)
      customEventInit[key] = params[key]
  Modal._events[eventName] = new CustomEvent(eventName, customEventInit)

# 扩展构造函数
Modal.addInitCallback = (callback, isUnshift) ->
  Modal._initCallBacks = Modal._initCallBacks or []
  if typeof callback == 'function'
    if isUnshift == true
      Modal._initCallBacks.unshift callback
    else
      Modal._initCallBacks.push callback
  else
    throw new TypeError(callback + ' must be a function')

# 打开弹层
Modal::open = ->
  events = Modal._events
  @el.classList.remove 'modal--close'
  @el.dispatchEvent events['modal:beforeOpen']
  @el.classList.add 'modal--open'
  @state = 'open'
  @el.dispatchEvent events['modal:opening']

# 关掉弹层
Modal::close = ->
  events = Modal._events
  @el.dispatchEvent events['modal:beforeClose']
  @el.classList.remove 'modal--open'
  @state = 'close'
  @el.dispatchEvent events['modal:closing']

# 销毁弹层
Modal::remove = ->
  events = Modal._events
  @el.removeEventListener 'transitionend', this
  @el.removeEventListener 'modal:beforeOpen', this
  @el.removeEventListener 'modal:afterClose', this
  @el.dispatchEvent events['modal:remove']
  @el.parentNode.removeChild @el

# 定义默认事件处理器
Modal::handleEvent = (event) ->
  events = Modal._events
  switch event.type
    when 'transitionend'
      switch @state
        when 'open'
          @el.dispatchEvent events['modal:afterOpen']
        when 'close'
          @el.dispatchEvent events['modal:afterClose']
    when 'modal:beforeOpen'
      document.body.classList.add 'body__modal--open'
      # 手动 reflow
      @el.clientWidth
    when 'modal:afterClose'
      document.body.classList.remove 'body__modal--open'
      if document.body.classList.length == 0
        document.body.removeAttribute 'class'
      @el.classList.add 'modal--close'

# 在初始化的时候绑定默认事件处理器
Modal.addInitCallback ->
  events = Modal._events
  @el.addEventListener 'transitionend', this
  @el.addEventListener 'modal:beforeOpen', this
  @el.addEventListener 'modal:afterClose', this

# 实例化时触发 'modal:init' 事件
Modal.addInitCallback ->
  @el.dispatchEvent Modal._events['modal:init']

# 初始化默认事件
Modal._initEvent()
window.MyModal = Modal
