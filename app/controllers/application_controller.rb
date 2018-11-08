class ApplicationController < Sinatra::Base

  set :public_folder, 'public'
  set :views, 'app/views'
  set :session_secret, "secret"
  enable :sessions
  register Sinatra::Flash

  get '/' do
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
