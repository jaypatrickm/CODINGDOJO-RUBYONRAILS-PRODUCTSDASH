class ProductsController < ApplicationController
  def index
    @products = Product.select("products.*, categories.name AS catname").joins(:category)
  end

  def show
    @product = Product.select("products.*, categories.name AS catname").joins(:category).find(params[:id])
    puts 'here is '
    puts params[:id]
    @commentlist = Comment.where(product_id:"#{params[:id]}")
    puts @commentlist
  end

  def new
    @categories = Category.all
  end

  def edit
    @product = Product.select("products.*, categories.name AS catname").joins(:category).find(params[:id])
    @categories = Category.all
  end

  def create
    puts product_params
    @product = Product.create( product_params )
    if @product.valid?
      redirect_to '/products/'
    else
      # @errors = @user.errors.messages
      puts @product.errors.full_messages
      flash[:name_error] = @product.errors.full_messages_for(:name) if @product.errors.messages.include?(:name)
      flash[:description_error] = @product.errors.full_messages_for(:description) if @product.errors.messages.include?(:description)
      flash[:pricing_error] = @product.errors.full_messages_for(:pricing) if @product.errors.messages.include?(:pricing)
      flash[:categories_error] = @product.errors.full_messages_for(:category_id) if @product.errors.messages.include?(:category_id)
      @categories = Category.all
      redirect_to '/products/new'
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.assign_attributes( product_params )
    if @product.valid?
      @product.save
      redirect_to '/products/'
    else
      flash[:name_error] = @product.errors.full_messages_for(:name) if @product.errors.messages.include?(:name)
      flash[:description_error] = @product.errors.full_messages_for(:description) if @product.errors.messages.include?(:description)
      flash[:pricing_error] = @product.errors.full_messages_for(:pricing) if @product.errors.messages.include?(:pricing)
      flash[:categories_error] = @product.errors.full_messages_for(:category_id) if @product.errors.messages.include?(:category_id)
      redirect_to '/products/' + params[:id] + '/edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to '/products/'
  end
  private 
    def product_params
      params.require(:product).permit(:name, :description, :pricing, :category_id)
    end
end
