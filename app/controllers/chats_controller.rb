class ChatsController < ApplicationController
  def show
    @chat = Chat.new
    @chats = Chat.all
  end

  def create
    @chat = Chat.new(chat_params)
    respond_to do |format|
      if @chat.save
        ActionCable.server.broadcast'room_channel',content:@chat
        format.html {redirect_to @chat}
        format.json {render :show, status: :created, location: @chat}
        format.js
      else
        format.html {render :new}
        format.json {render json: @chat.errors, status: :unprocessable_entity}
      end
  end
end
end
