Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :shorten, only: :create
  get '/:shortcode' => 'shorten#show'
  get '/:shortcode/stats' => 'shorten#stats'
end
