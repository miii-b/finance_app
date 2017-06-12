class SessionsController < ApplicationController
  before_action :require_user
  
  def index
    @sessions = Session.order(prepare_sort_params)
  end
  
end