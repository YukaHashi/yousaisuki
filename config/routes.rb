Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get '/homes/about' => "homes#about"
  get '/users/mypage' => "users#mypage"
  
  resources :posts, only: [:new, :create, :index, :show, :edit, :destroy]
  resources :users, only: [:show, :edit, :update]
  
end
