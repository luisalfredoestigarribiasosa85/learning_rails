require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "is valid with a name" do
    product = Product.new(name: "Keyboard")

    assert product.valid?
  end

  test "is invalid without a name" do
    product = Product.new(name: nil)

    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end
end
