module.exports = (app) ->

  init: (req, res, next) ->
    next()

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