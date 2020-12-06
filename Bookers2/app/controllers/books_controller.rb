class BooksController < ApplicationController
  before_action :correct_book,only: [:edit]

  def correct_book
    @book=Book.find(params[:id])
    if @book.user != current_user
       redirect_to books_path
    end
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
       redirect_to book_path(@book.id),notice:"You have created book successfully."
    else
       @books=Book.all
       @user=User.find_by(id: current_user.id)
       render :index
    end
  end

  def index
    @book=Book.new
    @books=Book.all
    @user=User.find_by(id: current_user.id)
  end

  def show
    @book=Book.new
    @book_show=Book.find(params[:id])
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id),notice:"You have updated book successfully."
    else
       render :edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
end
