class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable#,:confirmable

  has_many :books
  has_many :favorites
  has_many :book_comments
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attachment :profile_image, destroy: false
  has_many :user_rooms
  has_many :chats

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end

  include JpPrefecture
  jp_prefecture :prefecture_code, method_name: :pref

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end


  geocoded_by :address
  after_validation :geocode

  after_create :send_welcome_mail

  def send_welcome_mail
    UserMailer.user_welcome_mail(self).deliver
  end
  #reverse_geocoded_by :latitude, :longitude
  #after_validation :reverse_geocode, if: Proc.new { |a| a.latitude_changed? or a.longitude_changed? }


  #def self.search(method, word)
		#if method == "perfect_match"
			#@users = User.where("name LIKE ?", "#{word}")
		#elsif method == "forward_match"
			#@users = User.where("name LIKE ?", "#{word}%")
		#elsif method == "backward_match"
			#@users = User.where("name LIKE ?", "%#{word}")
		#elsif method == "partial_match"
			#@users = User.where("name LIKE ?", "%#{word}%")
		#else
			#@users = User.all
    #end
  #end

end

