class Review < ApplicationRecord
  belongs_to :product
  validates :author, presence: true
  validates :content_body, presence: true
  validates :rating, presence: true
  validates_length_of :content_body, minimum: 50, maximum: 250
  validates_numericality_of :rating, only_integer: true, greater_than: 0, less_than: 6


  scope :average_review, -> {( 
    select('product_id').group('product_id').average('rating')
    )}

  # scope :average_review, -> {(
  #   select("products.id, products.name, average(reviews.rating) as reviews_avg")
  #   .joins(:reviews)
  #   .group("products.id")
  #   .order("reviews_count DESC")
  #   .limit(1)
  # )}

  # Review.average(:rating)
  # Product.select("products.id")

end
