class UsersController < ApplicationController
	def new
		@user = User.new(user_params)
		# byebug
    if @user.save
	    render json: @user
	  else
	  	render json: { errors: @user.errors, cookies: request.cookies['secret'] }, status: 422
	  end
  end

  def signin
		render json: {email:'test', id: 1}
	end

	def authenticate
		if request.cookies['auth_email'].present? and 
			 request.cookies['auth_password'].present? 
			 render json: User.authenticate(request.cookies['auth_email'], request.cookies['auth_password'])
       
		end
	end

	def signup
		render json: {email:'test', id: 1}
	end

	def user_params
		params
      .permit(
        %w[
          email
          password
        ]
      )
		
	end
end
