require 'securerandom'
class LoginsController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      
      Session.where(user_id: user.id, status: 'active').update_all(status: Session.statuses[:force_logged_out])

      new_session = Session.create(user_id: user.id, validity: Time.now + Session::SESSION_VALIDITY , session_id: SecureRandom.hex.to_s, status: 'active')
      
      if new_session
        session[:sid] = new_session.session_id
        flash[:success]  = 'Successfully logged in'
        redirect_to root_path
      else
         flash[:danger]  = 'Session was not created'
         render 'new'
      end
    else
      flash[:danger] = 'Your email address or password does not match'
      render 'new'
    end
  end

  def destroy
    actual_session = Session.find_by(session_id: session[:sid]) if session[:sid]
    if actual_session && actual_session.active?
      actual_session.update(status: Session.statuses[:logged_out])
    end
    session[:sid] = nil
    flash[:danger]  = 'Successfully logged out'
    redirect_to root_path
  end
end