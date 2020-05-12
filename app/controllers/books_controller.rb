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
    if @book.save then render "show" else render "new" end 
  end
  
  def edit
    @book
  end

  def update
    if @book.user_id == current_user.id 
    @book.update(book_params)  
     render 'show' 
    else 
     render 'edit' 
    end   
  end

  def destroy
    if @book.user_id == current_user.id
     @book.destroy
    else
     render 'show'
    end
  end

  private
    
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description)
  end
end
