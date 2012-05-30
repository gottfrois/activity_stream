require 'faker'

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
    if params[:random] == "true"
      rand(200).times do
        activity = Activity.new(params[:activity])
        activity.actor   = User.all.entries[rand(User.count)]
        activity.subject = User.all.entries[rand(User.count)]
        rand(100).times do
          c = activity.comments.build(body: Faker::Lorem.sentence)
          c.author = User.all.entries[rand(User.count)]
          c.save!
        end
        activity.save!
      end
    else
      @activity = Activity.new(params[:activity])
      @activity.actor   = User.find(params[:actor][:actor_id])
      @activity.subject = User.find(params[:subject][:subject_id])
      render :new unless @activity.save!
    end
    redirect_to root_path, success: "Activity created!"
  end

  def delete
    Activity.find(params[:id]).delete
    redirect_to root_path, success: "Activity deleted!"
  end
end
