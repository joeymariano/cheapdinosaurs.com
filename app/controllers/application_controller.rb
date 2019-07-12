require 'net/http'
require 'json'
require 'sinatra/flash'

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
    response = Net::HTTP.get(uri)
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
end
