Pwckr::Application.routes.draw do
  root to: 'photos#index'
  get '/search/', to: 'photos#search', as: 'search'
end
