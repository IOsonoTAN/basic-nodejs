express = require('express')
app = require('express')()
http = require('http').Server(app)
global.io = require('socket.io')(http)
fs = require('fs')
stylus = require('stylus')
nib = require('nib')
bundle_up = require('bundle-up3')
assets = require('./assets')

for file in fs.readdirSync './apps'
  continue if file.search(/\.bak|\.disabled|^\./) > -1
  if file.search(/\.coffee/) < 0
    for file_sub in fs.readdirSync './apps/' + file
      continue if file_sub.search(/\.bak|\.disabled|^\./) > -1
      require("./apps/#{file}/#{file_sub}")(app)
  else
    require("./apps/#{file}")(app)

bundle_up app, assets,
  staticRoot: __dirname + '/public/'
  staticUrlRoot: '/'
  bundle: true
  minifyCss: true
  minifyJs: true
  complete: console.log.bind(console, 'Bundle-up: static files are minified/ready')

app.set('env', process.env.NODE_ENV or 'development')
app.set('port', process.env.PORT or 3000)
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.use(stylus.middleware({ src: "#{__dirname}/public/css", compile: compile }))
app.use(express.static(__dirname + '/public/'))

compile = (str, path) ->
  stylus(str).set('filename', path).use nib()

http.listen 3000, ->
  console.log('listening on http://localhost:3000/')