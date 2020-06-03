class CommentsController < ApplicationController

  before_action :set_comment, only: %i[show destroy update edit]
  before_action :authenticate_user!

  def index
    @comments = Book.find(params[:book_id]).comments
  end

  def new;
    if current_user.user_type == "reader"
      @comment = Comment.new
    else
      redirect_to book_url(params[:book_id])
    end
  end

  def create            #((user: current_user).merge(comment_params))
    if current_user.user_type == "reader"
      @comment = Book.find(params[:book_id]).comments.new(comment_params.merge(user: current_user))
      @comment.save
      redirect_to book_url(params[:book_id])
    else 
      render "new" 
    end
  end

  def show; end

  def edit; end

  def update
    if current_user.comments.find(params[:id]) 
      @comment.update(comment_params)  
      render 'show' 
    else
      flash.now[:error] = "You are not the author of the comment"
      render 'show'
    end
  end

  def destroy
    if current_user.comments.find(params[:id])
      @comment.destroy
      redirect_to books_url
    else
      flash.now[:error] = "You are not the author of the comment"
      render "show"
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:Comment).permit(:comment)
  end

end
