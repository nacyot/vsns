class UsersController < ApplicationController

  # TODO: make before_action callback method....

  layout "two_columns"

  def join

    @community = Community.find(params[:community_id])
    current_user.join!(@community)

    respond_to do | format |
      format.js
    end

  end  

  def leave
    
    @community = Community.find(params[:community_id])
    current_user.leave!(@community)

    respond_to do | format |
      format.js
    end
  end  


  def communities
    user = User.find(params[:id])
    if current_user == user
      @other_user = nil
      @communities = current_user.communities_owned_by_me
      @communities_joined = current_user.communities
    else
      @other_user = user
      @communities = user.communities_owned_by_me
      @communities_joined = user.communities
    end
  end
  
  def like 

    @user = User.find(params[:id])
    @likeable = params[:likeable_type].classify.constantize.send('find', params[:likeable_id])
    @user.like! @likeable

    respond_to do |format|
      format.js
    end

  end

  def dislike

    @user = User.find(params[:id])
    @likeable = params[:likeable_type].classify.constantize.send('find', params[:likeable_id])
    @user.dislike! @likeable

    respond_to do |format|
      format.js
    end
  end

  def followings
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followings.paginate(page: params[:page])
    @communities_joined = @user.communities
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @communities_joined = @user.communities
    render 'show_follow'
  end

  def follow
    @user = User.find(params[:id])
    @other_user = User.find(params[:other_id])
    @user.follow! @other_user
    respond_to do | format |
      format.js
    end
  end

  def unfollow
    @user = User.find(params[:id])
    @other_user = User.find(params[:other_id])
    @user.unfollow! @other_user
    respond_to do | format |
      format.js
    end
  end

end