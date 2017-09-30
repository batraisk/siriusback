Rails.application.routes.draw do
	scope :api do
		resource :users do
			get :signin
			get :authenticate
			post :new
		end
	end
end
