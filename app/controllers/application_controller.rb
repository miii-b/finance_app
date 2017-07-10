class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    actual_session = Session.find_by(session_id: session[:sid]) if session[:sid]

    ExpirationWorker.perform_in(5.minutes)
    if !actual_session || !actual_session.active? || actual_session.expired?
      @current_user = nil # not logged in
    else
      actual_session.update(validity: Time.now + Session::SESSION_VALIDITY)
      @current_user = actual_session.user
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'You must be logged in to perform that action'
      redirect_to new_login_path
    end
  end

  def prepare_sort_params
    direction = params[:direction] ? params[:direction] : 'ASC'
    sort = params[:sort] ? params[:sort] : 'id'
    sort + ' ' + direction
  end

end
