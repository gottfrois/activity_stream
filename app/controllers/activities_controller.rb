class ActivitiesController < ApplicationController
  before_filter :authenticate_user!, except: :index

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(params[:activity])
    @activity.actor = User.find(params[:actor][:actor_id])
    @activity.object = User.find(params[:object][:object_id])
    if @activity.save!
      redirect_to root_path, success: "Activity created!"
    else
      render :new
    end
  end

  def delete
    Activity.find(params[:id]).delete
    redirect_to root_path, success: "Activity deleted!"
  end
end
