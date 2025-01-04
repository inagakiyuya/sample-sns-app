class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["title", "post_content"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "user"]
  end
end
