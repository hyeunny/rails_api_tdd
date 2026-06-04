require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "POST /users with valid params creates a user and returns 201" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "new@example.com", password: "password123" } }, as: :json
    end
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "new@example.com", json["email"]
    assert_not json.key?("password_digest")
  end

  test "POST /users with invalid params returns 422" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email: "", password: "" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "POST /users with duplicate email returns 422" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email: users(:alice).email, password: "password123" } }, as: :json
    end
    assert_response :unprocessable_entity
  end
end
