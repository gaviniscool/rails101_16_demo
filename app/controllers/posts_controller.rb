class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group
  before_action :member_required, only: [:new, :create]

  def new
    # @group = Group.find(params[:group_id])
    @post = @group.posts.new
  end

  def create
    # @group = Group.find(params[:group_id])
    @post = @group.posts.build(post_params)
    @post.author = current_user
    # the way of delivering params to database seems different here

    if @post.save
      redirect_to group_path(@group), notice: 'post added!'
    else
      render :new
    end
  end

  def edit
    # @group = Group.find(params[:group_id])
    @post = current_user.posts.find(params[:id])
  end

  def update
    # @group = Group.find(params[:group_id])
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: 'post modified!'
    else
      render :edit
    end
  end

  def destroy
    # @group = Group.find(params[:group_id])
    @post = current_user.posts.find(params[:id])

    @post.destroy
    redirect_to group_path(@group), alert: 'post deleted!'
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "not a member, request denied"
      redirect_to group_path(@group)
    end

  end

end
