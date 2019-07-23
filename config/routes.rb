Rails.application.routes.draw do
  resources :players, only: [:index, :show], path_names: { index: 'overview' }
  resources :teams, only: :show

  get '/teams' => redirect('/players')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
