require 'config/environment'

require 'cuba'
require 'warden'
require 'pry' unless Application.environment.production?

Warden::Strategies.add :basic do
  def auth
    @_auth ||= Rack::Auth::Basic::Request.new env
  end

  def valid?
    auth.provided? and auth.basic?
  end

  def authenticate!
    if auth.credentials == [ENV['SHUMOKU_API_USER'], ENV['SHUMOKU_API_PASS']]
      success! auth.credentials.first
    else
      fail! 'Forbidden'
    end
  end
end

class API < Cuba
  module Authentication
    def authenticate!
      env['warden'].authenticate!
    end
  end

  class Forbidden < Cuba
    define do
      on 'unauthenticated' do
        res.status = 403
        res.write JSON message: 'Forbidden'
      end
    end
  end

  use Warden::Manager do |manager|
    manager.default_strategies :basic
    manager.failure_app = Forbidden
  end

  def self.port
    Integer ENV['PORT'] || 3000
  end

  def self.environment
    Application.environment
  end

  plugin Authentication

  define do
    on 'v1' do
      authenticate!

      # declare api here

    end
  end
end

# require api here
