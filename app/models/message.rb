class Message < ActiveRecord::Base
  validates :text, :user, presence: true
  belongs_to :user

  def unread?(user)
    id > user.read_to
  end
end
