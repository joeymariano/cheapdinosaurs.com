$:.unshift '.'
require 'config/environment'

use Rack::Static

use Rack::MethodOverride
run ApplicationController
