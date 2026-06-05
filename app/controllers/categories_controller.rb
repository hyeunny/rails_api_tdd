class CategoriesController < ApplicationController
  def index
    render json: Category.all
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: { errors: category.errors }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
