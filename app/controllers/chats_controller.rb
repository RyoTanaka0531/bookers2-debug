class ChatsController < ApplicationController
  def show
    @chats = Chat.all
  end
end
