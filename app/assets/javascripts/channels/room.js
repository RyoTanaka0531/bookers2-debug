App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    console.log("connetc!")
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function() {
    var node = document.createElement("P");
    var textnode = document.createTextNode(data.content.message);
    node.appendChild(textnode);
    document.getElementByld("new_content").appendChild(node);
    document.getElementByld('chat_content').value=''
    // Called when there's incoming data on the websocket for this channel
  }
});
