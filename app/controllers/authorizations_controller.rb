class AuthorizationsController < ApplicationController
	def signin

		render json: {email:'test', id: 1}
	end

	def signup
		
		render json: {email:'test', id: 1}
	end
end
