class CategoriesController < ApplicationController
  before_action :require_user
 
  class InvalidDateRange < StandardError
  end
  rescue_from InvalidDateRange do
    flash[:alert] = 'Wrong range entered. Using default values'

    redirect_to :categories
  end

  def index
    @categories = Category.order(prepare_sort_params)
    validate_dates(params)
  end

  def new
    @category = Category.new
  end

  def edit
     @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Successfully created post!'
      redirect_to categories_path
    else
      flash[:alert] = 'Error creating new post!'
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path, notice: 'Category was successfully updated'
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def validate_dates(params)
    validate_form(params[:from])
    validate_to(params[:to])
    raise InvalidDateRange if @from > @to
  end

  def validate_form(from)
    if from == '' || from.nil?
      # user default when empty
      @from = Time.at(0)
    else
      # from = to, set whole day
      @from = Time.parse(from).beginning_of_day
    end
  end

  def validate_to(to)
    if to == '' || to.nil?
      @to = Time.now
    else
      # from = to, set whole day
      @to = Time.parse(to).end_of_day
    end
  end
end
