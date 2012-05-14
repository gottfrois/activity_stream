class ActivitiesController < ApplicationController
  def index
    @activities = NewsFeed::Activity.all
  end

  def show
    @activity = NewsFeed::Activity.find(params[:id])
  end

  def new
    @activity = NewsFeed::Activity.new
  end

  def create
    @activity = NewsFeed::Activity.new(params[:news_feed_activity])
    @activity.actor = User.find(params[:actor][:actor_id])
    @activity.object = User.find(params[:object][:object_id])
    if @activity.save!
      redirect_to root_path, success: "Activity created!"
    else
      render :new
    end
  end

  def delete
    NewsFeed::Activity.find(params[:id]).delete
    redirect_to root_path, success: "Activity deleted!"
  end
end
