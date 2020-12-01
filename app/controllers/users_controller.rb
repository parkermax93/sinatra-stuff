class UsersController < ApplicationController
    get '/signup' do
        if !logged_in?
            erb :"/users/signup"
        else
            redirect to "/games"
        end
    end

    post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/signup"
        else
            @user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to "/games"
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/games'
        end
    end

    post '/login' do
        user = User.find_by(:name => params[:name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/games'
        else
            redirect to '/signup'
        end
    end

    get '/show' do 
        @user = current_user 
        erb :'users/show'
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end
  end