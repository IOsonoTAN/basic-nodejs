$ ->
  $('#m').focus()
  socket = io()
  $('form').submit (e) ->
    e.preventDefault()
    socket.emit 'chat message', $('#m').val()
    $('#m').val ''
  socket.on 'chat message', (msg) ->
    $('#messages').append $('<li>').text(msg)