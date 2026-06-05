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
end
