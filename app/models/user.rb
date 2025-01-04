class User < ApplicationRecord
  authenticates_with_sorcery!
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def mine?(object)
    object.user_id == id
  end
end
