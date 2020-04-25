class ChatsController < ApplicationController
  def show
    @chat = Chat.new
    @chats = Chat.all
  end
end
