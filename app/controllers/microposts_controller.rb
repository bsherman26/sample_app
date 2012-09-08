class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path[0,root_path.length-1]
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path[0,root_path.length-1]
  end

  private
    
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path[0,root_path.length-1] if @micropost.nil?
    end
end
