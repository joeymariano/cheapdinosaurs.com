require 'net/http'
require 'json'
require 'sinatra/flash'
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

  post '/code-auth' do
    if code_auth(params['code'])
      flash[:notice] = 'success'
      session[:show_link] = true
      redirect back
    else
      flash[:notice] = 'try again please'
      redirect back
    end
  end

  get '/download' do
    if session[:show_link]
      signer = Aws::S3::Presigner.new
      mp3 = signer.presigned_url(:get_object, bucket: "cheapdinosaurs", key: "sicktunes/mp3/sicktunes_mp3.zip")
      wav = signer.presigned_url(:get_object, bucket: "cheapdinosaurs", key: "sicktunes/wav/sicktunes_wav.zip")
      @mp3link = mp3.to_s
      @wavlink = wav.to_s
      flash[:notice] = 'success'
    end

    erb :'download'
  end

  get '/' do
    url = "https://api.songkick.com/api/3.0/artists/1892714/calendar.json?apikey=#{ENV['SONGKICK_API_KEY']}"
    uri = URI(url)
    response = Net::HTTP.get(uri) # should try to get this to still load when songkick or internet is down
    result = JSON.parse(response)
    @events = result['resultsPage']['results']['event']
    erb :'root'
  end

  def code_auth(code)
    codes = ENV['CODE_LOOKUP'].split(',')
    return codes.any? do |c|
      c.downcase == code
    end
  end
end