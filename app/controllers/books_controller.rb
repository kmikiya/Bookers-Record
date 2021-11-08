class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @created_6daysago = @books.created_6daysago.count
    @created_5daysago = @books.created_5daysago.count
    @created_4daysago = @books.created_4daysago.count
    @created_3daysago = @books.created_3daysago
    @created_2daysago = @books.created_2daysago
    @created_yesterday = @books.created_yesterday
    @created_today = @books.created_today
    
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
