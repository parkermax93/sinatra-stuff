class GamesController < ApplicationController
    get '/games' do
        if logged_in?
            @game = Game.all 
            erb :"/games/index"
        else
            redirect to "/login"
        end
    end

    get '/games/new' do 
        erb :'games/new'
    end

    post '/games' do
        if logged_in?
            if params[:title] == ""
                redirect to "/games/new"
            else
                @game = Game.create(title: params[:title], user_id: current_user.id)
                if @game.save 
                    redirect to "/games/#{@game.id}"
                else
                    redirect to "/games/new"
                end
            end
        else 
            redirect to "/games/new"
        end
    end

    get '/games/:id' do
        if logged_in?
            @game = Game.find_by_id(params[:id])
            erb :'/games/show'
        else
            redirect 'login'
        end
    end

    get '/games/:id/edit' do
        if logged_in? 
            @game = Game.find_by_id(params[:id])
            if @game && @game.user_id == current_user.id 
                erb :'games/edit'
            else
                redirect to '/games'
            end
        else
            redirect to 'login'
        end
    end

    patch '/games/:id/edit' do 
        if logged_in? 
            if params[:title] == ""
                redirect to "/games/#{params[:id]}/edit"
            else
                @game = Game.find_by_id(params[:id])
                if @game && @game.user_id == current_user.id 
                    if @game.update(title: params[:title], user_id: current_user.id)
                        redirect to "/games/#{@game.id}"
                    else
                        redirect to "/games/#{game.id}/edit"
                    end
                else 
                    redirect to "/games"
                end
            end
        else
            redirect to "/login"
        end
    end

    delete '/games/:id/delete' do 
        if logged_in?
            @game = Game.find_by_id(params[:id])
            if @game && @game.user.id == current_user.id 
                @game.delete 
            end
            redirect to "/games"
        else redirect to "/logged_in"
        end
    end
end