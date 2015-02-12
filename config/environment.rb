require 'config/application'

unless Application.environment.production?
  require 'dotenv'
  Dotenv.load
end

require 'moped'
require 'cooperator'

Store = Moped::Session.new [ENV['TOKUMX_URL']]

if ENV['TOKUMX_AUTH_DB'] and ENV['TOKUMX_AUTH_USER'] and ENV['TOKUMX_AUTH_PASS']
  Store.use 'admin'
  Store.login ENV['TOKUMX_AUTH_USER'], ENV['TOKUMX_AUTH_PASS']
end

Store.use ENV['TOKUMX_DB']

require 'app/interactors'
