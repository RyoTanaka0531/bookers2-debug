class UsersController < ApplicationController
  before_action :authenticate_user!
	before_action :baria_user, only: [:update, :edit]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def create
  @user = User.new(params_user)
  @user.address = @user.city + @user.street
  @shop.address = @shop.address.gsub(/\d+/, "").gsub(/\-+/, "")
  @user.save, notice = 'Welcome! You have signed up successfully.'
  redirect_to user_path  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
	  @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(current_user.id), notice: "successfully updated user!"
    else
      #@book = Book.new
      #@books = Book.all
  		render "edit"
  	end
  end

  def following
    @title = "Follow Users"
    @user = User.find(params[:id])
    @users = @user.following.all
    render 'show_follow'
  end

  def followers
    @title = "Follower Users"
    @user = User.find(params[:id])
    @users = @user.followers.all
    render 'show_follow'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :city, :street, :address, :latitude, :longitude)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end
end
