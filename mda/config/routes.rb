Rails.application.routes.draw do
  resources :season_standings
  resources :divisions
  resources :seasons
  resources :memberships
  resources :matches
  resources :teams
  resources :players
  resources :accolaids

  get '/seasons/:id/stats', to: 'seasons#stats'
  get '/standings/generate/:season', to: 'season_standings#generate'
  get '/matches/weekly/:week/:season_id', to: 'matches#weekly'
  get '/test', to: 'matches#test'
  root :to => 'season_standings#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
