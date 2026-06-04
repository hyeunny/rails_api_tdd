require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid with email and password" do
    user = User.new(email: "test@example.com", password: "password123")
    assert user.valid?
  end

  test "invalid without email" do
    user = User.new(password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "invalid with duplicate email" do
    User.create!(email: "test@example.com", password: "password123")
    user = User.new(email: "test@example.com", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "invalid without password" do
    user = User.new(email: "test@example.com")
    assert_not user.valid?
  end

  test "email is stored downcased" do
    user = User.create!(email: "TEST@EXAMPLE.COM", password: "password123")
    assert_equal "test@example.com", user.email
  end
end
