class FavoritesController < ApplicationController
  def creat
    @book = Book.find(params[:book_id])
    @book.favorite(current_user)
  end

  def destroy
    @book = Favorite.find(params[:id]).book
    @book.unfavorite(current_user)
  end
end
