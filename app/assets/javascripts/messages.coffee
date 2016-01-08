@flash_element = (element) ->
  oldBG = element.style.background
  oldTra = element.style.transition
  element.style.backgroundColor = '#faa'
  setTimeout(->
    element.style.transitionDuration = '.5s'
    element.style.transitionProperty= 'background-color'
    element.style.backgroundColor = 'transparent'
  , 300)
  element.addEventListener 'transitionend', ->
    element.style.transition = oldTra
    element.style.background = oldBG

$ ->
  $('#message_post_form')
    .on 'ajax:before', ->
      message_area = document.getElementById('message_area')
      message = message_area.value
      if message.length == 0
        flash_element(message_area)
        return false
    .on 'ajax:success', (event, data, status, xhr) ->
      message_area.value = ''
    .on 'ajax:error', (event, xhr, status, error) ->
      alert error

  # To avoid event conflict on turbolinks
  $(window).off("smartscroll")

  $("#messages").infinitescroll
    loading: {
      finishedMsg: "end",
    }
    binder: $("#messages"),
    behavior: 'local',
    animate: true,
    maxPage: 20,
    navSelector: "nav.pagination"
    nextSelector: "nav.pagination a[rel=next]"
    itemSelector: "#messages li"
