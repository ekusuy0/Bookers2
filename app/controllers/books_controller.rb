class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params2)
    @book.user_id = current_user.id
    if @book.save
      if @book.save
        flash[:notice] = "You have created book successfully."
        redirect_to book_path(@book.id)
      end
    else
      @books = Book.all
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params1)
      if @book.update(book_params1)
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
      end
    else
      render :edit
    end
  end

  private

  def book_params1
    params.require(:book).permit(:title, :body)
  end

  def book_params2
    params.permit(:title, :body)
  end

end
