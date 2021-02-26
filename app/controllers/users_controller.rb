class UsersController < ApplicationController
    get '/users/signup' do
      if logged_in?
        redirect "/users/#{@user.id}"
      else
        erb :'/users/signup'
      end
    end 

    post '/signup' do
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      if @user.valid?
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      elsif @user.invalid? && User.find_by(username: @user.username)
        puts "Sorry, that username is already taken."
        erb :'users/signup'
      else
        puts "Oops! Please make sure to fill out all criteria."
        erb :'users/signup'
      end
    end
  
    get '/users/login' do
      if logged_in?
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        erb :'/users/login'
      end
    end
  
    post '/login' do
      @user = User.find_by(username: params[:username])
  
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        puts "Welcome back, #{@user.username}!"
        redirect "/users/#{@user.id}"
      else
        puts "There was trouble logging in. Please try again."
        redirect to '/users/login'
      end
    end
  
    get '/users/:id' do
      @user = User.find_by_id(params[:id])
      @books = Book.all
      erb :'/users/show'
    end
  
    get '/logout' do
      if logged_in?
        session.clear
        redirect '/'
      else
        redirect '/'
      end
    end
  end  