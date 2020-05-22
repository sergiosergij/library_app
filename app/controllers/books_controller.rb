class BooksController < ApplicationController
  before_action :set_book, only: %i[show destroy update edit]
  before_action :authenticate_user!

  def index
    @books = Book.where("title LIKE ?","%#{params[:search]}%")
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save then redirect_to (@book) else render "new" end 
  end
  
  def edit; end

  def update
    if current_user.books.find(params[:id]) 
    @book.update(book_params)  
     render 'show' 
    else
     flash.now[:error] = "You are not the author of the book" 
     render 'show' 
    end   
  end

  def destroy
    if current_user.books.find(params[:id])
     @book.destroy
     redirect_to books_url
    else
      flash.now[:error] = "You are not the author of the book"
      render  'show'
    end
  end

  def author
    @books = current_user.books.where("title LIKE ?","%#{params[:search]}%") #Book.where(user_id: current_user.id)
  end

  private
    
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description)
  end
end
