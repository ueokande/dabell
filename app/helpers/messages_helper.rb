module MessagesHelper
  def format(source)
    result = Rails.application.config.pipeline.call(source)[:output]
    return result.gsub(/(\r\n|\r|\n)/, "<br />")
  end
end
