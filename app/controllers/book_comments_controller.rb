class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.build(book_comment_params)
    @book_comment.user = current_user
    @book_comment.save
    redirect_back(fallback_location: book_url(@book.id))
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find(params[:id])
    @book_comment.destroy
    redirect_back(fallback_location: book_path(@book.id))
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:body)
  end


end