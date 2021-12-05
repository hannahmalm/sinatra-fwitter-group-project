class TweetsController < ApplicationController

    get "/tweets/index" do 
        redirect_login
        @tweet = Tweet.find_by_id(params[:id])
        @user = User.find_by_id(params[:id])
        erb :'/tweets/index'
    end 

    get "/tweets/new" do 
        redirect_login
        erb :'/tweets/new'
    end 

    post "/tweets" do 
        redirect_login
        log = Log.new(:content => params[:content])
        if log.save 
            redirect to "/tweets/#{tweet.id}"
        else 
            redirect to "/tweets/new"
            flash[:error] = "Your tweet cannot be empty!"
        end 
    end 

    get "/tweets/:id" do 
        redirect_login
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show'
    end 
end
