require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "GET /posts returns 200 with all posts" do
    get posts_url
    assert_response :ok
    json = JSON.parse(response.body)
    assert_kind_of Array, json
  end

  test "GET /posts/:id returns 200 with the post" do
    post = posts(:one)
    get post_url(post)
    assert_response :ok
    json = JSON.parse(response.body)
    assert_equal post.id, json["id"]
    assert_equal post.title, json["title"]
    assert_equal post.body, json["body"]
  end

  test "GET /posts/:id returns 404 when not found" do
    get post_url(id: 0)
    assert_response :not_found
  end

  test "POST /posts with valid params creates a post and returns 201" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { title: "New Post", body: "New body", user_id: users(:alice).id, category_id: categories(:technology).id } }, as: :json
    end
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "New Post", json["title"]
    assert_equal "New body", json["body"]
  end

  test "POST /posts with invalid params returns 422" do
    assert_no_difference("Post.count") do
      post posts_url, params: { post: { title: "", body: "" } }, as: :json
    end
    assert_response :unprocessable_entity
  end
end
