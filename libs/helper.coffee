module.exports = (app) ->
  init: (req, res, next) ->
    res.locals.currentUrl = req.originalUrl
    res.locals.site_name = config.site_name
    next()

  # checklogin: (req, res, next) ->
  #   if !req.session.auth
  #     req.session.originalUrl = req.originalUrl
  #     res.redirect '/auth/google'
  #   else
  #     next()

  rand: ($range) ->
    text = ''
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    i = 0
    while i < $range
      text += possible.charAt(Math.floor(Math.random() * possible.length))
      i++
    text

  t: ($text) ->
    '{' + $text + '}'