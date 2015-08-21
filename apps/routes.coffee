module.exports = (app) ->

  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/test', (req, res) ->
    res.render 'test'

  app.get '/local/:language', (req, res) ->
    res.send req.__('Hello')