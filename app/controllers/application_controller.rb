require './config/environment'
require './app/models/user'

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
    # @user = User.find(session[:user_id])
    # if @user
    #   erb :index
    # else
    #   redirect 'sign_in'
    # end
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
    erb :message
  end

  post '/sign_up' do
    User.create(username: params[:username], name: params[:name], email: params[:email],
     bolt_connection: params[:bolt_connection], profile_picture: params[:profile_picture])
    redirect '/'
  end

  post 'sign_in' do
    @user = User.find_by(username: params[:username], email: params[:email])
    if @user
      session[:user_id] = @user.id
      redirect '/'
    else
      @error_message = "Bolt doesn't remember that login information. Please 
      try again, or follow the sign-up link to create a new account."
      erb :sign_in
    end
  end

end
