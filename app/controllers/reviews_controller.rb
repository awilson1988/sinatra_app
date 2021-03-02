class ReviewsController < ApplicationController
    get '/reviews/index' do
      @reviews = Review.all 
      erb :'review/index'
    end
  
    get '/reviews/new' do
      erb :'/reviews/new'
    end
  
    post '/reviews' do
      @review = Review.new(params) 
      @review.user_id = session[:user_id] 
      @review.save
      redirect "/reviews/#{@review.id}" 
      
    end
  
    get '/reviews/:id' do
      get_review 
      erb :'review/show'
    end
  
    get '/reviews/:id/edit' do
      redirect_if_not_logged_in
  
      @review = Review.find_by_id(params[:id])
      if @review.user == current_user
        @books = Book.all
        erb :'/reviews/edit'
      else
        redirect to "/reviews/#{params[:id]}"
      end
    end
  
    patch '/reviews/:id' do
      redirect_if_not_logged_in
  
      @review = Review.find_by_id(params[:id])
      @book = Book.find_by_id(@review.book_id)
  
      if @review.invalid?
        flash[:error] =  "Oops! Make sure to fill out all criteria!"
        erb :'/reviews/edit'
      else
        if @review && @review.user == current_user
          if params[:new_book_name].empty?
            @book.update(name: params[:book_name])
          else
            @book.update(name: params[:new_book_name])
          end
  
          @review.update( book_id: @book.id, user_id: current_user.id)
          flash[:error] =  "Review successfully updated."
          redirect to "/reviews/#{params[:id]}"
        else
          redirect to '/reviews'
        end
      end
    end
  
    delete '/reviews/:id/delete' do
      redirect_if_not_logged_in
  
      @review = Review.find_by_id(params[:id])
      if @review && @review.user == current_user
        @review.delete
        flash[:error] = "Review has been deleted."
        redirect to "/users/#{@review.user_id}"
      else
        redirect to "/reviews/#{params[:id]}"
      end
    end
  end