Rails.application.config.pipeline = HTML::Pipeline.new [
  HTML::Pipeline::PlainTextInputFilter,
  HTML::Pipeline::AutolinkFilter
]
