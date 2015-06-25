module.exports = (assets) ->
  
  ### Global ###
  assets.addCss(__dirname + '/public/css/global.styl')
  assets.addCssUrl('/libs/bootstrap-3.3.5-dist/css/bootstrap.min.css')
  assets.addJsUrl('/libs/jquery-1.11.3.js')
  assets.addJsUrl('/libs/bootstrap-3.3.5-dist/js/bootstrap.min.js')

  ### Chat ###
  assets.addJsUrl('/socket.io/socket.io.js', 'chat')
  assets.addJs(__dirname + '/public/js/chat.coffee', 'chat')