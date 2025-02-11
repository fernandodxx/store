class Product < ApplicationRecord
  include Notifications
  has_one_attached :featured_image
  has_rich_text :description
  has_many :reviews, dependent: :destroy
  has_many :subscribers, dependent: :destroy

  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }

  def average_rating
    return 0 if reviews.empty?

    reviews.average(:rating).round(1)
  end
end
