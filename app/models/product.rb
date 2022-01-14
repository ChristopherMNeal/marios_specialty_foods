class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :country_of_origin, presence: true
  validates :cost, presence: true
  validates_numericality_of :cost, greater_than: 0, less_than_or_equal_to: 999999.99
  before_save(:titleize_product)

  scope :most_recent, -> { order(created_at: :desc).limit(3) }
  scope :most_reviews, -> {(
    select("products.id, products.name, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(1)
  )}
  scope :local, -> { where(country_of_origin: "Dune") }
  scope :featured, -> { where(featured: true) }

  def self.search(search)
    if search 
        where(["name LIKE ?","%#{search}%"])
    else
        @products = Product.all
    end
  end

  scope :average_review, -> {( select('product_id').group('product_id').average('rating').to_i )}

  # scope :average_review, -> {(
  #   select("products.id, products.name, average(reviews.rating) as reviews_avg")
  #   .joins(:reviews)
  #   .group("products.id")
  #   .order("reviews_count DESC")
  #   .limit(1)
  # )}

  # Review.average(:rating)
  # Product.select("products.id")

  private
    def titleize_product
      self.name = self.name.titleize
    end
end