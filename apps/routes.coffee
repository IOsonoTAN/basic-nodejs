module.exports = (app) ->

  # Pass variables to jade
  app.use (req, res, next) ->
    res.locals.current_url = req.originalUrl
    res.locals.site_name = config.site_name
    next()
  
  app.get '/', helper.init, (req, res) ->
    res.render 'index', app: 'application'

  app.get '/member', helper.init, (req, res) ->
    res.render 'index', app: 'application'

  app.get '/member/login', helper.init, (req, res) ->
    res.render 'index', app: 'application'