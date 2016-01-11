class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    rendered = ApplicationController.renderer.render(partial: 'messages/message',
                                                     locals: { message: message })
    ActionCable.server.broadcast('messages_channel', message: rendered)
  end
end
