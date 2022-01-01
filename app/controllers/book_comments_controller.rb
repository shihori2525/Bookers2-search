class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(post_comment_params)
    comment.book_id = @book.id
    comment.save
    redirect_to book_path(@book)
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_back fallback_location: books_path
  end

private

  def post_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
