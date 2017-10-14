class ApplicationController < ActionController::API
  before_action :set_current_user

  def set_current_user
  	if request.cookies['auth_email'].present? &&
	   request.cookies['auth_token'].present?
	   @current_user = 
	     User.authenticate(request.cookies['auth_email'], request.cookies['auth_token'])
	end
  end

end
