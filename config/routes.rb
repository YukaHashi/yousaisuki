Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get '/homes/about' => "homes#about"
  get '/users/mypage' => "users#mypage"
  # 退会確認画面
  get '/users/check' => "users#check"
  # 退会処理（論理削除）
  patch '/users/withdraw' => "users#withdraw"
  
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update]
  
end
