Rails.application.routes.draw do
	scope :api do
		resource :authorizations do
			get :signin
			get :signup
		end
	 get 'signup',  :to => "users#new"
	end
end
