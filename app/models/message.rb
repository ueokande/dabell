class Message < ActiveRecord::Base
  validates :text, :user, presence: true
  belongs_to :user

  def unread?(user)
    user.created_at ? true : created_at > user.last_sign_in_at_was
  end
end
