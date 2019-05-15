class Entry < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope ->{order(created_at: :desc)}

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_max}
  validates :title, presence: true, length: {maximum: Settings.title_max}
end
