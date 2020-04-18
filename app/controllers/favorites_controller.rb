class FavoritesController < ApplicationController
  def creat
    @book = Book.find(params[:book_id])
    unless @book.favorite?(current_user)
      @book.favorite(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  def destroy
    @book = Favorite.find(params[:id]).book
    if @book.favorite?(current_user)
      @book.unfavorite(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
  end
end
