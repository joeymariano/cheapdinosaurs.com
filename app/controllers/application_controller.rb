require 'net/http'
require 'json'
require 'sinatra/flash'
require 'pry'

class ApplicationController < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  set :public_folder, 'public'
  set :views, 'app/views'


  before do
    if Sinatra::Base.environment == :development
      require 'dotenv/load'
    end
  end

  get '/' do
    url = "https://api.songkick.com/api/3.0/artists/1892714/calendar.json?apikey=#{ENV['SONGKICK_API_KEY']}"
    uri = URI(url)
    response = Net::HTTP.get(uri) # should try to get this to still load when songkick or internet is down
    result = JSON.parse(response)
    @events = result['resultsPage']['results']['event']
    erb :'root'
  end

  post '/email' do
    email = Email.new(email: params['email'])
    if email.save
      flash[:notice] = "thanks for signing up ;)"
      redirect to "/"
    else
      flash[:notice] = "hmm... try again maybe."
      redirect to "/"
    end
  end

  get '/download' do
    @link = ENV['SICKTUNES'].to_s
    erb :'download'
  end

  post '/code-auth' do
    if code_auth(params['code'])
      flash[:notice] = 'success'
      flash[:link] = 'true'
      redirect to "/download"
    else
      flash[:notice] = 'try again please'
      flash[:link] = 'false'
      redirect to "/download"
    end
  end

  def code_auth(code)
    codes = ENV['CODE_LOOKUP'].split(',')
    return codes.any? do |c|
      c.downcase == code
    end
  end
end