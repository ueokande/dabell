App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data['method'] == 'create'
      element = $(data['message'])
      element.addClass('unread').appendTo($('#messages')).css('opacity', 0)
      window.getComputedStyle(element[0]).opacity
      element.css('opacity', 1)
      $('#messages').scrollBottom(0)
    else if data['method'] == 'destroy'
      element = $("[data-message-id=#{data['id']}]")
      element.css('opacity', 0)
      setTimeout(
        -> element.remove()
      , 300)
