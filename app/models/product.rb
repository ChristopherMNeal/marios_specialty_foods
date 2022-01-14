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

  def ratings_average
    ratings = self.review.where(created_at: 1.hour.ago..Time.now).order(:created_at).group(:user_id)

    ratings.sum(:value) / ratings.count
  end

  # TRYING TO MAKE AN AVERAGE SCORE SCOPE
  # scope :best_reviews, -> {(
  #   select("products.id, products.name, review.rating, count(reviews.rating) as ratings_count")
  #   .joins(:reviews)
  #   .group("reviews.id")
  #   .order("ratings_ DESC")
  #   .limit(1)
  # )}

  private
    def titleize_product
      self.name = self.name.titleize
    end
end