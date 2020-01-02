require 'net/http'
require 'json'
require 'sinatra/flash'
require 'pry'
require 'aws-sdk'

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
    if flash[:notice]
      s3 = Aws::S3::Resource.new
      bucket = s3.bucket('cheapdinosaurs')
      binding.pry

      # mp3 = bucket.objects('sicktunes/mp3')[0]
      # wav = bucket.objects('sicktunes/wav')[0]

      # mp3.url_for(:get, { :expires => 20.minutes.from_now, :secure => true }).to_s
      # wav.url_for(:get, { :expires => 20.minutes.from_now, :secure => true }).to_s

      # @mp3link = mp3
      # @wavlink = wav

      flash[:notice] = flash[:notice]
    end

    erb :'download'
  end

  post '/code-auth' do
    if code_auth(params['code'])
      flash[:notice] = 'success'
      redirect to "/download"
    else
      flash[:notice] = 'try again please'
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