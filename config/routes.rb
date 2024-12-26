Rails.application.routes.draw do

  # 不要となるルーティング(管理者の新規登録とパスワード機能)を無効にする
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get '/homes/about' => "homes#about"
  get '/users/mypage' => "users#mypage"
  # 退会確認画面
  get '/users/check' => "users#check"
  # 退会処理（論理削除）
  patch '/users/withdraw' => "users#withdraw"
  
  get "search" => "searches#search"

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update]
  
end
