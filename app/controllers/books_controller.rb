class BooksController < ApplicationController  
  #render form to create books
  get '/books/new' do
  end
   
  #create books
  post '/books' do
  end

  #show all books
  get '/books' do
    @books = Book.all
    erb :'/books/index'
  end
  
  #show single book
    get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    erb :'/books/show'
  end
    
  #renders form to edit book
    get '/books/:id/edit' do 
  end

  #updates book
  patch '/books/:id' do
  end

  #deletes existing user
  delete '/books/:id' do
  end





end