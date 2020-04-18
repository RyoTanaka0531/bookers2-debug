class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorite(user)
		favorites.create(user_id: user.id)
	end

	def unfavorite(user)
		favorites.find_by(user_id: user.id).destroy
	end

	def favorite?(user)
		favorite_users.include?(user)
	end
end
