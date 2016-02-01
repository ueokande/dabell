module ApplicationHelper
  def app_name
    ENV['APP_NAME'] || Rails.application.class.parent_name
  end
end
