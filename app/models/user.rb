class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable

  IMAGE_STYLES = { normal: '64x64#' }
  IMAGE_TYPE = %w(image/jpeg image/png image/gif).map(&:freeze)
  has_attached_file :avatar,
    styles: IMAGE_STYLES,
    default_style: :normal,
    default_url: 'noavatar.png'
  validates_attachment_content_type :avatar, content_type: IMAGE_TYPE

end
