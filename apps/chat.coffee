module.exports = (app) ->
  app.get '/chat', (req, res) ->
    res.render 'chat', app: 'application'

  io.on 'connection', (socket) ->
    socket.client.name = Math.random()
    console.log socket.client.id + ' connected'
    socket.broadcast.emit 'chat message', 'Welcome ' + socket.client.name
    socket.on 'disconnect', ->
      console.log socket.client.id + ' disconnected'
    socket.on 'chat message', (msg) ->
      console.log 'message: ' + msg
      io.emit 'chat message', socket.client.name + ': ' + msg