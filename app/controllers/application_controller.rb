require './config/environment'
require './app/models/user'
require './app/models/message'


class ApplicationController < Sinatra::Base

  configure do
    configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end
  end

  get '/' do
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    erb :index
  end

  get '/sign_out' do
    session[:user_id] = nil
    erb :index
  end

  get '/sign_up' do
    erb :sign_up
  end

  get '/sign_in' do
    erb :sign_in
  end

  get '/bolt_gifs' do
    erb :bolt_gifs
  end

  get '/message' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :message
    else 
      redirect '/sign_in'
    end
  end

  get '/profile' do
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    erb :profile
  end

  post '/sign_up' do
    puts params[:profile_picture]
    @user = User.new(username: params[:username], name: params[:name], email: params[:email],
     bolt_connection: params[:bolt_connection], birthday: params[:birthday], profile_picture: params[:profile_picture][:filename])
    @user.password = params[:password]
    @user.save
    File.open('public/profile_pictures/' + params['profile_picture'][:filename], "w") do |f|
      f.write(params['profile_picture'][:tempfile].read)
    end
    redirect '/'
  end

  post '/sign_in' do
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/'
    else
      @error_message = "Bolt doesn't remember that login information. Please 
      try again, or follow the sign-up link to create a new account."
      erb :sign_in
    end
  end

  post "/sign_out" do
    session[:user_id] = nil
    redirect '/'
  end

  post '/message' do
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    @message = Message.new(@user.name, params[:message])
    # this creates a new connection to the Twilio API
    @client = Twilio::REST::Client.new('ACed3ed813257f8acedfce46a695216257','cb1dd832eda91ea39319fe6827f1650b')

    # this creates a message and sends it out via Twilio
    @client.messages.create(
      from: '+14342605034', # this is the Flatiron School's Twilio number
      to: '8042634562',
      body: @message.message
    )
  end

end