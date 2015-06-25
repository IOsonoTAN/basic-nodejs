(function() {

  $(function() {
    var socket;
    $('#m').focus();
    socket = io();
    $('form').submit(function(e) {
      e.preventDefault();
      socket.emit('chat message', $('#m').val());
      return $('#m').val('');
    });
    return socket.on('chat message', function(msg) {
      return $('#messages').append($('<li>').text(msg));
    });
  });

}).call(this);
