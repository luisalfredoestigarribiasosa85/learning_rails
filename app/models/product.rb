class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  scope :active, -> { where(active: true) }
  scope :in_stock, -> { where("stock > ?", 0) }

  def available?
    active? && stock > 0
  end

  def formatted_price
    "$%.2f" % price
  end

  def stock_status
    return "out_of_stock" if stock == 0
    return "low_stock" if stock <= 5
    "in_stock"
  end
end
