class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.build(book_id: params[:book_id])
    favorite.save
    #render :index
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    favorite.destroy
    #render 'destroy.js.erb'
    #render :index
  end
end
