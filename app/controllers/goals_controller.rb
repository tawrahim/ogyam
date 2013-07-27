class GoalsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    @goal = current_user.goals.build(params[:goal])
    if @goal.save
      flash[:success] = "Goal created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @goal.destroy
    redirect_to root_path
  end
  
  private

    def correct_user
      @goal = current_user.goals.find_by_id(params[:id])
      redirect_to root_path if @goal.nil? 
    end
end
