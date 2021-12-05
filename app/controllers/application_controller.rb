require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "tweetpass"
    register Sinatra::Flash
  end

  get "/" do 
    erb :homepage
  end 
  get "/signup" do 
    if logged_in? 
        redirect to "/tweets/index"
    else 
        erb :'signup'
    end 
end 

post "/signup" do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""  #if params are empty 
         redirect to "/signup" #redirect back to signup page 
    else #if user params are populated, create the user & set the session & redirect to their account 
        @user = User.create(username: params[:username], email: params[:email])
        session[:user_id] = @user.id 
        redirect to "/tweets/index"
    end 
end 


get "/login" do #render the login form 
  erb :'/users/login'
end     

post "/login" do 
  @user = User.find_by(username: params[:username], email: params[:email])
  if @user &&  @user.authenticate(params[:password])
      session[:user_id] = @user.id 
      redirect "/tweets/index" #loads the tweets index after login
  else 
      redirect to "/login"
  end 
end 
  helpers do 
    def current_user 
      @current_user == User.find_by(id: session[:user_id]) 
    end 

    def logged_in?
      !!current_user
    end 

    def redirect_login
      if !current_user
        redirect to "/login"
      end 
    end 
  end  
end
