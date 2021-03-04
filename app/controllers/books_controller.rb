class BooksController < ApplicationController
    get '/books' do
      erb :'/books/index'
    end
  
    get '/books/:id' do
      @user = current_user
      @book = Book.find_by_id(params[:id])
      erb :'/books/show'
    end
  end