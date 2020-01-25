require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'
require 'net/http'
require 'json'
require 'aws-sdk'

if Sinatra::Base.environment == :development
  require 'dotenv/load'
end

Bundler.require(:default)

require_all 'app'
