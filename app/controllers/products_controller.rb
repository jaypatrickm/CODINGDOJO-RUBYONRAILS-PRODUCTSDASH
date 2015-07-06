class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
  end

  def new

  end

  def edit
  end

  def create
    @product = Product.create( product_params )
    if @user.valid?
      redirect_to '/users/'
    else
      # @errors = @user.errors.messages
      @first_name_error = @user.errors.full_messages_for(:first_name) if @user.errors.messages.include?(:first_name)
      @last_name_error = @user.errors.full_messages_for(:last_name) if @user.errors.messages.include?(:last_name)
      @email_address_error = @user.errors.full_messages_for(:email_address) if @user.errors.messages.include?(:email_address)
      @password_error = @user.errors.full_messages_for(:password) if @user.errors.messages.include?(:password)
      render "new"
    end
  end

  def update
  end

  def destroy
  end
  private 
    def product_params
      params.require(:product).permit(:name, :description, :pricing)
    end
end
