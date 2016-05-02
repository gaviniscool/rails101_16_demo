class Account::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    # current_user.posts.order("updated_at DESC") cound use 'recent' after add scope in post model
    @posts = current_user.posts.recent
  end

end
