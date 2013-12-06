Pwckr::Application.routes.draw do
  root to: 'photos#index'
  get '/list', to: 'photos#list', as: 'list'
end
