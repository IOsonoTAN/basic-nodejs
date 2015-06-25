module.exports = (app) ->
  app.get '/', helper.init, (req, res) ->
    res.render 'index', app: 'application'

  app.get '/member', helper.init, (req, res) ->
    res.render 'index', app: 'application'

  app.get '/member/login', helper.init, (req, res) ->
    res.render 'index', app: 'application'