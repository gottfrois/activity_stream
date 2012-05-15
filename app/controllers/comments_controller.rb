class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_author, only: :destroy

  def create
    @item = find_item
    @comment = @item.comments.build(params[:comment])
    @comment.author = current_user
    if @comment.save!
      redirect_to root_path, success: "Comment created!"
    else
      redirect_to root_path, error: "An error has occured."
    end
  end

  def update
    @item = find_item
    @comment = @item.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to root_path, success: "Comment updated!"
    else
      redirect_to root_path, error: "An error has occured."
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path
  end

private

  def find_item
    params.each do |name, value|
      return @item = $1.classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

  def require_author
    @item = find_item
    @comment = @item.comments.find(params[:id])
    redirect_to :back, :error => 'You are not allowed to do that.' unless @comment.author?(current_user)
  end
end
