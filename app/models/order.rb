class Order < ApplicationRecord
  before_validation :set_total!

  belongs_to :user
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }, absence: false
  validates :user_id, presence: true
  validates_with EnoughProductsValidator

  has_many :placements
  has_many :products, through: :placements


  def set_total!
    self.total = 0
    placements.each do |p|
      self.total += p.product.price * p.quantity
    end
  end

  # Buid placement object and once we save the order everthing will be saved to the database
  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |ps_ids_and_qs|
      id, quantity = ps_ids_and_qs
      self.placements.build(product_id: id, quantity: quantity)
    end
  end
end
