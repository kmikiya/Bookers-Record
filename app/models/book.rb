class Book < ApplicationRecord
  belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 

scope :created_6daysago, -> { where(created_at: 7.day.ago.beginning_of_day..6.day.ago.end_of_day) } 
scope :created_5daysago, -> { where(created_at: 6.day.ago.beginning_of_day..5.day.ago.end_of_day) } 
scope :created_4daysago, -> { where(created_at: 5.day.ago.beginning_of_day..4.day.ago.end_of_day) } 
scope :created_3daysago, -> { where(created_at: 4.day.ago.beginning_of_day..3.day.ago.end_of_day) } 
scope :created_2daysago, -> { where(created_at: 3.day.ago.beginning_of_day..2.day.ago.end_of_day) } 


	
end
