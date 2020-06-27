class GamesController < ApplicationController
    get '/games' do
        if logged_in?
            @game = Game.all 
            erb :"/games/index"
        else
            redirect to "/login"
        end
    end

    post '/games' do
    end

    get '/games/:id' do
    end

    get '/games/:id/edit' do
    end

    put '/games/:id' do
    end

    delete '/games:id' do
    end
end