require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "POST /categories with valid params creates a category and returns 201" do
    assert_difference("Category.count") do
      post categories_url, params: { category: { name: "Cooking" } }, as: :json
    end
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "Cooking", json["name"]
  end

  test "POST /categories with invalid params returns 422" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "POST /categories with duplicate name returns 422" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: categories(:sports).name } }, as: :json
    end
    assert_response :unprocessable_entity
  end
end
