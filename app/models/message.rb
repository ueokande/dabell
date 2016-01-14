class Message < ActiveRecord::Base
  validates :text, :user, presence: true
  belongs_to :user
  after_create_commit { MessageBroadcastJob.perform_later self }
end
