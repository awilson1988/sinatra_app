class BooksController < ApplicationController
    get '/books' do
      erb :'/books/index'
    end
  
    get '/books/:id' do
      redirect_if_not_logged_in
  
      @user = current_user
      @book = Book.find_by_id(params[:id])
      erb :'/books/show'
    end
  end