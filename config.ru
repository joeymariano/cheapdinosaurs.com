$:.unshift '.'
require 'config/environment'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/flash'
require 'net/http'
require 'json'
require 'aws-sdk'

if Sinatra::Base.environment == :development
  require 'dotenv/load'
end

run ApplicationController
