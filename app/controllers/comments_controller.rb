class CommentsController < ApplicationController
  def index
  	@comments = Comment.select("comments.*, products.name").joins(:product)
  end
  def create
  	@comment = Comment.create( comment_params )
    if @comment.valid?
      redirect_to '/products/'+ comment_params[:product_id]
    else
      # @errors = @user.errors.messages
      flash[:content_error] = @comment.errors.full_messages_for(:content) if @comment.errors.messages.include?(:content)
      @product = Product.select("products.*, categories.name AS catname").joins(:category).find(comment_params[:product_id])
      redirect_to '/products/'+ comment_params[:product_id]
    end

  end
  private
  	def comment_params
  		params.require(:comment).permit(:content, :product_id)
  	end
end
