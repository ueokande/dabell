class Message < ActiveRecord::Base
  validates :text, :user, presence: true
  belongs_to :user
  default_scope -> { order('created_at DESC') }
end
