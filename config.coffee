# ENV
env = process.env.NODE_ENV || 'development'
process.env.NODE_ENV = env

config = 
  default: 
    site_name: 'Basic NodeJS'

  production:
    session_secret: 'app-on-production'
    host:
      self: process.env.SELF_URL or 'http://localhost/'

  development:
    session_secret: 'app-dev'
    host:
      self: 'http://localhost:3000' or "http://localhost:#{process.env.PORT}"

module.exports = _.merge(config['default'], config[env])