class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @goal = current_user.goals.build
      @feed_items = current_user.feed
    end
  end

  def help
  end

  def about
  end

  def blog
  end

  def terms
  end

  def press
  end
end
