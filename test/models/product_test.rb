require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @laptop = products(:laptop)
    @out_of_stock = products(:out_of_stock)
  end

  test "is valid with a name and price" do
    product = Product.new(name: "Keyboard", price: 79.99, stock: 10)
    assert product.valid?
  end

  test "is invalid without a name" do
    product = Product.new(name: nil, price: 79.99)
    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end

  test "is invalid without a price" do
    product = Product.new(name: "Keyboard", stock: 10)
    assert_not product.valid?
    assert_includes product.errors[:price], "can't be blank"
  end

  test "is invalid with negative price" do
    product = Product.new(name: "Keyboard", price: -10, stock: 10)
    assert_not product.valid?
    assert_includes product.errors[:price], "must be greater than or equal to 0"
  end

  test "is invalid with negative stock" do
    product = Product.new(name: "Keyboard", price: 79.99, stock: -5)
    assert_not product.valid?
    assert_includes product.errors[:stock], "must be greater than or equal to 0"
  end

  test "formatted_price returns price with dollar sign" do
    assert_equal "$999.99", @laptop.formatted_price
  end

  test "available? returns true when active and in stock" do
    assert @laptop.available?
  end

  test "available? returns false when inactive" do
    assert_not @out_of_stock.available?
  end

  test "available? returns false when out of stock" do
    product = Product.new(name: "Test", price: 10, stock: 0, active: true)
    assert_not product.available?
  end

  test "stock_status returns out_of_stock when stock is 0" do
    assert_equal "out_of_stock", @out_of_stock.stock_status
  end

  test "stock_status returns low_stock when stock is 5 or less" do
    product = Product.new(name: "Test", price: 10, stock: 3)
    assert_equal "low_stock", product.stock_status
  end

  test "stock_status returns in_stock when stock is more than 5" do
    assert_equal "in_stock", @laptop.stock_status
  end

  test "active scope returns only active products" do
    active_products = Product.active
    assert_includes active_products, @laptop
    assert_not_includes active_products, @out_of_stock
  end

  test "in_stock scope returns only products with stock" do
    in_stock = Product.in_stock
    assert_includes in_stock, @laptop
    assert_not_includes in_stock, @out_of_stock
  end
end
