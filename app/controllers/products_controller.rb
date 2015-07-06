class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new

  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.create( product_params )
    if @product.valid?
      redirect_to '/products/'
    else
      # @errors = @user.errors.messages
      @name_error = @product.errors.full_messages_for(:name) if @product.errors.messages.include?(:name)
      @description_error = @product.errors.full_messages_for(:description) if @product.errors.messages.include?(:description)
      @pricing_error = @product.errors.full_messages_for(:pricing) if @product.errors.messages.include?(:pricing)
      render "new"
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.assign_attributes( product_params )
    if @product.valid?
      @product.save
      redirect_to '/products/' + params[:id]
    else
      @name_error = @product.errors.full_messages_for(:name) if @product.errors.messages.include?(:name)
      @description_error = @product.errors.full_messages_for(:description) if @product.errors.messages.include?(:description)
      @pricing_error = @product.errors.full_messages_for(:pricing) if @product.errors.messages.include?(:pricing)
      render "new"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to '/products/'
  end
  private 
    def product_params
      params.require(:product).permit(:name, :description, :pricing)
    end
end
