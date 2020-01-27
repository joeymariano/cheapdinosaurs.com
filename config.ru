$:.unshift '.'
require 'sinatra'
require 'config/environment'

run ApplicationController
