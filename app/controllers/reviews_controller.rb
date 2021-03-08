class ReviewsController < ApplicationController    
  
  #render form to edit review
  get '/reviews/:id/edit' do
    @review = Review.find_by(id:params[:id])
    erb :'reviews/edit'
  end
  
  #updates review
  patch '/books/:id' do
    book = Book.find_by(id:params[:id])
    review = Review.find_by(id:params[:id])
    review.update(comments: params[:comments])
    redirect "/books/#{book.id}"
  end 

  #deletes review
  delete '/reviews/:id' do
    book = Book.find_by(id:params[:id])
    review = Review.find_by(id:params[:id])
    review.delete
    redirect "/books/#{book.id}"
  end

end 
  
  