class Message < ActiveRecord::Base
  validates :text, :user, presence: true
  belongs_to :user
end
