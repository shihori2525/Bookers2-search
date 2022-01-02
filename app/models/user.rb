class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

  has_many :relationships, foreign_key: :follower_id,dependent: :destroy
  has_many :followers, through: :relationships, source: :followed

  has_many :reverse_of_relationships,class_name: "Relationship",foreign_key: :followed_id,dependent: :destroy
  has_many :followed, through: :reverse_of_relationships,source: :follower

 def follow(other_user)
   unless self == other_user
     self.relationships.find_or_create_by(followed_id: other_user.id)
   end
 end

 def unfollow(other_user)
   relationship = self.relationships.find_by(followed_id: other_user.id)
   relationship.destroy if relationship
 end

 def following?(other_user)
   self.followers.include?(other_user)
 end

  attachment :profile_image, destroy: false

  def favorited_by?(book)
		self.favorites.exists?(book_id: book.id)
  end

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
