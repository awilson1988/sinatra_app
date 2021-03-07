class ReviewsController < ApplicationController
    get '/reviews' do
      @reviews = Review.all 
      erb :'review/index'
    end
  
    get '/reviews/new' do
      erb :'reviews/new'
    end
  
    post '/reviews' do
    
      @review = Review.new(params) 
      @review.user_id = session[:user_id] 
      @review.save
      redirect "/reviews/#{@review.id}" 
      
    end
  
    get '/reviews/:id' do
      @review = Review.find_by(id:params[:id])
      erb :'reviews/show'
     end

    get '/reviews/:id/edit' do
      @review = Review.find_by(id:params[:id])
      if @review.author == current_user
      erb :'reviews/edit'
    end
  
    patch '/reviews/:id' do
      @review = Review.find_by(id:params[:id])
      @review.update(title: params[:title], comments: params[:comments])
      redirect "/reviews/#{@review.id}"
    end 
  
     
  
    delete '/reviews/:id' do
       @review = Review.find_by(id:params[:id])
        @review.destroy
        redirect to "/reviews"
      end
    end
  end