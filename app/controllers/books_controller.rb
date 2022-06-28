class BooksController < ApplicationController

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    #includesは一回でbookに紐づいている情報を取り出せるようにするためのもの、ここではbookに紐づいている:favorited_usersを一回で呼び出す
    @books = Book.includes(:favorited_users).
      sort {|a,b|
      #whereはモデル名.where(カラム名: 条件)でcreate_atカラムからtoからfromまでをすべて取得
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
    @user = @book.user
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
    unless View.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.views.create(book_id: @book.id)
    end
    
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
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
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
