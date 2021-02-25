class UsersController < ApplicationController
    get '/users/signup' do
      if logged_in?
        redirect "/users/#{@user.id}"
      else
        erb :'/users/signup'
      end
    end 

     