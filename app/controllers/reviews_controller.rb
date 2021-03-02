class ReviewsController < ApplicationController
    get '/reviews' do
      redirect_if_not_logged_in
  
      @user = current_user
      session[:user_id] = @user.id
      @reviews = Review.all
      erb :'/reviews/index'
    end
  
    get '/reviews/new' do
      redirect_if_not_logged_in
  
      @books = Book.all
      erb :'/reviews/new'
    end
  
    post '/reviews' do
      if params[:new_book_name].empty?
        @book = Book.find_or_create_by(name: params[:book_name])
      else
        @book = Book.find_or_create_by(name: params[:new_book_name])
      end
  
      @review = review.new
      @user = current_user
      @review.user_id = @user.id
      @review.book_id = @book.id
      @review.save
  
      flash[:message] = "You have successfully created the review."
      redirect to "/reviews/#{@review.id}"
  
      if @review.invalid?
        flash[:message] =  "Oops! Make sure to fill out all criteria!"
        erb :'/users/show'
      end
    end
  
    get '/reviews/:id' do
      redirect_if_not_logged_in
  
      @user = current_user
      @review = Review.find_by_id(params[:id])
      @book = Book.find_by_id(@review.book_id)
      erb :'/reviews/show'
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
        flash[:message] =  "Oops! Make sure to fill out all criteria!"
        erb :'/reviews/edit'
      else
        if @review && @review.user == current_user
          if params[:new_book_name].empty?
            @book.update(name: params[:book_name])
          else
            @book.update(name: params[:new_book_name])
          end
  
          @review.update( book_id: @book.id, user_id: current_user.id)
          flash[:message] =  "Review successfully updated."
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
        puts "Review has been deleted."
        redirect to "/users/#{@review.user_id}"
      else
        redirect to "/reviews/#{params[:id]}"
      end
    end
  end