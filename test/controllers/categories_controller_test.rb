require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "GET /categories returns 200 with all categories as JSON" do
    get categories_url
    assert_response :ok
    json = JSON.parse(response.body)
    assert_kind_of Array, json
  end

  test "GET /categories includes name for each category" do
    get categories_url
    assert_response :ok
    json = JSON.parse(response.body)
    assert json.all? { |c| c.key?("name") }, "Every category entry should have a 'name' key"
  end

  test "GET /categories returns all seeded categories" do
    get categories_url
    assert_response :ok
    json = JSON.parse(response.body)
    names = json.map { |c| c["name"] }
    assert_includes names, categories(:technology).name
    assert_includes names, categories(:science).name
  end

  test "POST /categories with valid params creates a category and returns 201 with JSON" do
    post categories_url, params: { category: { name: "Sports" } }, as: :json
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "Sports", json["name"]
  end

  test "POST /categories with missing name returns 422 with errors" do
    post categories_url, params: { category: { name: "" } }, as: :json
    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert json.key?("errors"), "Response body should include an 'errors' key"
  end

  test "POST /categories with duplicate name returns 422 with errors" do
    post categories_url, params: { category: { name: categories(:technology).name } }, as: :json
    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert json.key?("errors"), "Response body should include an 'errors' key"
  end
end
