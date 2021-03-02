class UsersController < ApplicationController
  get '/users/signup' do
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.valid?
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    elsif @user.invalid? && User.find_by(username: @user.username)
      flash[:message] = "Sorry, that username is already taken."
      erb :'/users/signup'
    else
      flash[:message] = "Please make sure to fill out all criteria."
      erb :'/users/signup'
    end
  end

  get '/users/login' do
     erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome back, #{@user.username}!"
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "There was trouble logging in. Please try again."
      redirect to '/users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end
