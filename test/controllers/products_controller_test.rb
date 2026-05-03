require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:laptop)
    @admin = users(:admin)
    @regular_user = users(:user)
  end

  # ====================
  # ADMIN TESTS
  # ====================

  test "admin should get index" do
    sign_in @admin
    get products_url
    assert_response :success
  end

  test "admin should get new" do
    sign_in @admin
    get new_product_url
    assert_response :success
  end

  test "admin should create product with valid params" do
    sign_in @admin
    assert_difference("Product.count", 1) do
      post products_url, params: { product: { name: "Mouse" } }
    end
    assert_redirected_to product_url(Product.last)
  end

  test "admin should not create product with invalid params" do
    sign_in @admin
    assert_no_difference("Product.count") do
      post products_url, params: { product: { name: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "admin should show product" do
    sign_in @admin
    get product_url(@product)
    assert_response :success
  end

  test "admin should get edit" do
    sign_in @admin
    get edit_product_url(@product)
    assert_response :success
  end

  test "admin should update product with valid params" do
    sign_in @admin
    patch product_url(@product), params: { product: { name: "Updated Product" } }
    assert_redirected_to product_url(@product)
    assert_equal "Updated Product", @product.reload.name
  end

  test "admin should destroy product" do
    sign_in @admin
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end
    assert_redirected_to products_url
  end

  # ====================
  # REGULAR USER TESTS
  # ====================

  test "regular user should get index" do
    sign_in @regular_user
    get products_url
    assert_response :success
  end

  test "regular user should show product" do
    sign_in @regular_user
    get product_url(@product)
    assert_response :success
  end

  test "regular user should not get new" do
    sign_in @regular_user
    get new_product_url
    assert_redirected_to products_path
    assert_equal "You don't have permission to perform this action.", flash[:alert]
  end

  test "regular user should not create product" do
    sign_in @regular_user
    assert_no_difference("Product.count") do
      post products_url, params: { product: { name: "Mouse" } }
    end
    assert_redirected_to products_path
    assert_equal "You don't have permission to perform this action.", flash[:alert]
  end

  test "regular user should not get edit" do
    sign_in @regular_user
    get edit_product_url(@product)
    assert_redirected_to products_path
    assert_equal "You don't have permission to perform this action.", flash[:alert]
  end

  test "regular user should not update product" do
    sign_in @regular_user
    original_name = @product.name
    patch product_url(@product), params: { product: { name: "Updated Product" } }
    assert_redirected_to products_path
    assert_equal "You don't have permission to perform this action.", flash[:alert]
    assert_equal original_name, @product.reload.name
  end

  test "regular user should not destroy product" do
    sign_in @regular_user
    assert_no_difference("Product.count") do
      delete product_url(@product)
    end
    assert_redirected_to products_path
    assert_equal "You don't have permission to perform this action.", flash[:alert]
  end

  # ====================
  # UNAUTHENTICATED TESTS
  # ====================

  test "unauthenticated user should be redirected to login" do
    get products_url
    assert_redirected_to new_user_session_path
  end
end
