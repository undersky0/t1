class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @newsfeed=Newsfeed.new
    @newsfeed.log(NEWSFEED_STREAM_VERBS[:new_user],'new_user',@user.beamer_id,@user.class.to_s,"#{@user.first_name} #{@user.last_name}",nil,nil,nil,nil,nil,0)
    if @user.save && @newsfeed.save #&& @user.create_beamer_node
      redirect_to root_url,:notice => "You have been registered successfully.You can now log in."
    else
      flash[:error]=@user.errors.full_messages
      render :action => "new"
    end
  end

  def show
      @user = User.find_by_beamer_id(params[:id])
  end

  def showconnections
    flash[:notice]
    @user = User.find_by_beamer_id(params[:beamer_id])
    @all_connections=User.all
  end

end
