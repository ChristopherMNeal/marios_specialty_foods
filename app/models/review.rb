class Review < ApplicationRecord
  belongs_to :product
  validates :author, presence: true
  validates :content_body, presence: true
  validates :rating, presence: true
  validates_length_of :content_body, minimum: 50, maximum: 250
  validates_numericality_of :rating, only_integer: true, greater_than: 0, less_than: 6
# TRYING TO MAKE AN AVERAGE SCORE SCOPE
  # scope :best_reviews, -> {(
  #   select("products.id, products.name, review.rating, count(reviews.rating) as ratings_count")
  #   .joins(:reviews)
  #   .group("reviews.id")
  #   .order("ratings_ DESC")
  #   .limit(1)
  # )}
end