class UsersController < ApplicationController
	def new
	  user = User.new(user_params)
      if user.save
	    # render json: @user
	    render json: user
	  else
	  	render json: { errors: @user.errors }, status: 422
	  end
    end

    def signin
      user = User.where(email: user_params['email']).first if auth_by_password?

      if user.present?
	    render json: user
	  else
		render json: { errors: { user: 'don\'t exist' }}, status: 422
	  end
	end 

	def authenticate
	  if @current_user
		render json: @current_user, status: 200
	  else
		render json: { errors: {user: 'not authorizarion'}}, status: 401
	  end
	end

	def auth_by_password?
	  user_params['email'].present? && 
	  user_params['password'].present? &&
      User.auth_by_password?(user_params['email'], user_params['password'])
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
