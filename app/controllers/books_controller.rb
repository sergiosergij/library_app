class BooksController < ApplicationController
  before_action :set_book, only: [:show, :destroy, :update, :edit]
  before_action :authenticate_user!

  def index
    @book = Book.all
  end

  def show
    @book 
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save  
      render "show"  
    else 
      render "new"
    end 
  end
  
  def edit
    @book
  end

  def update
    @book
    if @book.update(book_params)
        render 'show'
    else
        render 'edit'
    end   
  end

  def destroy
    @book.destroy
  end

  private
    
  def set_book
    @book = Book.find(params[:id])
  end
   
  def book_params
    params.require(:book).permit(:title, :description)
  end
end
