require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "valid with a name" do
    category = Category.new(name: "Technology")
    assert category.valid?
  end

  test "invalid without a name" do
    category = Category.new(name: nil)
    assert_not category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "invalid with a duplicate name" do
    Category.create!(name: "Technology")
    duplicate = Category.new(name: "Technology")
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end
end
