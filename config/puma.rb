require 'app/api'

workers Integer(ENV['PUMA_WORKERS'] || 1)
threads Integer(ENV['PUMA_MIN_THREADS'] || 10), Integer(ENV['PUMA_MAX_THREADS'] || 10)

preload_app!

rackup      DefaultRackup
port        API.port
environment API.environment

on_worker_boot do
end
