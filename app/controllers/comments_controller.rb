class CommentsController < ApplicationController
  before_filter :find_item, only: [:create, :update, :destroy]

  def create
    @comment = @item.comments.build(params[:comment])
    if @comment.save!
      redirect_to root_path, success: "Comment created!"
    else
      redirect_to root_path, error: "An error has occured."
    end
  end

  def update
    @comment = @item.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to root_path, success: "Comment updated!"
    else
      redirect_to root_path, error: "An error has occured."
    end
  end

  def destroy
    @item.comments.find(params[:id]).destroy
  end

private

  def find_item
    params.each do |name, value|
      return @item = $1.classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end
end
