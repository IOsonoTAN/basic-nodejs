express = require('express')
app = require('express')()
http = require('http').Server(app)
global.io = require('socket.io')(http)
fs = require('fs')
stylus = require('stylus')
nib = require('nib')
bundle_up = require('bundle-up3')
cookieParser = require('cookie-parser')
assets = require('./assets')
global.moment = require('moment')
global.i18n = require('i18n')
global._ = require('lodash')
global.helper = require('./libs/helper')(app)
global.params = require('./libs/params')(app)
global.config = require('./config')

i18n.configure
  locales: ['en', 'th']
  cookie: 'i18nCookie'
  directory: __dirname + '/locales'

# Bundle files under public folder.
bundle_up app, assets,
  staticRoot: __dirname + '/public/'
  staticUrlRoot: '/'
  bundle: true
  minifyCss: false
  minifyJs: true
  complete: console.log.bind(console, 'Bundle-up: static files are minified/ready')

# Express app configuration.
app.set('env', process.env.NODE_ENV or 'development')
app.set('port', process.env.PORT or 3000)
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.set('site_name', config.site_name)
app.use(stylus.middleware({ src: "#{__dirname}/public/css", compile: compile }))
app.use(express.static(__dirname + '/public/'))
app.use(cookieParser())
app.use(i18n.init)

# Pass variables to jade.
app.use (req, res, next) ->
  res.locals.current_url = req.originalUrl
  res.locals.site_name = config.site_name
  next()

# Run app routes under apps folder.
for file in fs.readdirSync './apps'
  continue if file.search(/\.bak|\.disabled|^\./) > -1
  if file.search(/\.coffee/) < 0
    for file_sub in fs.readdirSync './apps/' + file
      continue if file_sub.search(/\.bak|\.disabled|^\./) > -1
      require("./apps/#{file}/#{file_sub}")(app)
  else
    require("./apps/#{file}")(app)

app.get '*', (req, res) ->
  res.send '404 page not found.', 404

# Compile stylus to stylesheet.
compile = (str, path) ->
  stylus(str).set('filename', path).use nib()

# Listen server and generate port.
http.listen 3000, ->
  console.log('listening on http://localhost:3000/')