require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @admin = User.new(email: "admin@test.com", password: "password123", role: "admin")
    @user = User.new(email: "user@test.com", password: "password123", role: "user")
  end

  test "admin? returns true for admin role" do
    assert @admin.admin?
    assert_not @admin.user?
  end

  test "user? returns true for user role" do
    assert @user.user?
    assert_not @user.admin?
  end

  test "is invalid with invalid role" do
    invalid_user = User.new(email: "invalid@test.com", password: "password123", role: "superuser")
    assert_not invalid_user.valid?
    assert_includes invalid_user.errors[:role], "is not included in the list"
  end

  test "default role is user" do
    new_user = User.new(email: "new@test.com", password: "password123")
    assert_equal "user", new_user.role
  end
end
