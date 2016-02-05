module MessagesHelper
  def format(source)
    result = Rails.application.config.pipeline.call(source)[:output]
    result.gsub(/(\r\n|\r|\n)/, '<br />')
  end
end
