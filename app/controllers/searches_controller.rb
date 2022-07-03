class SearchesController < ApplicationController

  def search
    @word = params[:word]
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "Book"
      @books = Book.looks(params[:search], params[:word])
    elsif @range == "Tag"
      @tags = Tag.looks(params[:search], params[:word])
    end
  end
end
