Rails.application.routes.draw do
  resources :departments
  resources :offers do
    get 'search', on: :collection
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
