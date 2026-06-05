require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "valid with title, body, and author" do
    post = Post.new(title: "Hello", body: "World", user: users(:alice), category: categories(:technology))
    assert post.valid?
  end

  test "invalid without author" do
    post = Post.new(title: "Hello", body: "World")
    assert_not post.valid?
    assert_includes post.errors[:user], "must exist"
  end

  test "invalid without title" do
    post = Post.new(body: "World")
    assert_not post.valid?
    assert_includes post.errors[:title], "can't be blank"
  end

  test "invalid without body" do
    post = Post.new(title: "Hello")
    assert_not post.valid?
    assert_includes post.errors[:body], "can't be blank"
  end

  test "belongs to a category" do
    post = posts(:one)
    assert_respond_to post, :category
    assert_instance_of Category, post.category
  end

  test "invalid without a category" do
    post = Post.new(title: "Hello", body: "World", user: users(:alice), category: nil)
    assert_not post.valid?
    assert_includes post.errors[:category], "must exist"
  end
end
