Rails.application.routes.draw do
  get 'player/list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
