class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  has_many :likes
  has_many :bookmarks
  has_many :users, through: :likes
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :post_content, presence: true, length: { maximum: 65_535 }

  def self.ransackable_attributes(auth_object = nil)
    ["title", "post_content"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "user"]
  end
end
