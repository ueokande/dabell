class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(options)
    if options[:method] == 'create'
      rendered = ApplicationController.renderer.render(
        partial: 'messages/message',
        locals: { message: options[:message], broadcast: true })
      ActionCable.server.broadcast('messages_channel',
                                   method: 'create', message: rendered)
    end
  end
end
