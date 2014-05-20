class ApplicationController < ActionController::Base
	protect_from_forgery
	include ApplicationHelper
	include NewsfeedsStreamsData
  helper :all
  protect_from_forgery
  helper_method :current_user_session, :current_user, :require_user, :recipients

  private
  def recipients
    curr_u = current_user
    User.all.reject { |u| u.beamer_id == curr_u.beamer_id }.compact
  end
  
  def set_flash_message(key, kind, options = {})
    message = find_message(kind, options)
    flash[key] = message if message.present?
  end

  def find_message(kind, options = {})
    I18n.t("#{controller_name}.#{kind}", options)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_to signin_path
      return false
    end
  end
end
