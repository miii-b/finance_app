class CategoriesController < ApplicationController
  before_action :require_user
 
  class InvalidDateRange < StandardError 
  end

  rescue_from InvalidDateRange do
    flash[:alert] = "Wrong range entered. Using default values"

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
      flash[:notice] = "Successfully created post!"
      redirect_to categories_path
    else
      flash[:alert] = "Error creating new post!"
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
    if params[:from]=='' || params[:from] == nil
      @from = Time.at(0) 
    else
      @from = Time.parse(params[:from]).beginning_of_day  
    end

    if params[:to]=='' || params[:to] == nil
      @to = Time.now 
    else
      @to = Time.parse(params[:to]).end_of_day
    end

    raise InvalidDateRange if @from > @to 
  end
end






