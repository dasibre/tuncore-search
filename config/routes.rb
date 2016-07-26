Rails.application.routes.draw do
  get 'library/search'
	root 'library#index'
end
