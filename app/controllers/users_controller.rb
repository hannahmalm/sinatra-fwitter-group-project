class UsersController < ApplicationController
   

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


    get "/users/:id" do 
        redirect_login
        @user = User.find_by(id: params[:id]) #find the users id 
        erb :'/users/show'  #render users show page 
    end 

    post "/logout" do 
        if logged_in?
            session.clear
        else 
            redirect to "/login"
        end 
    end 

end

