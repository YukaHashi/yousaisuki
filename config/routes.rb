Rails.application.routes.draw do

  # 不要となるルーティング(管理者の新規登録とパスワード機能)を無効にする
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    # 投稿一覧および投稿削除画面
    resources :post_comments, only: [:index, :destroy]
  end
  
  scope module: :public do
    devise_for :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root to: "homes#top"
    get '/homes/about' => "homes#about"
    get '/users/mypage' => "users#mypage"
    # 退会確認画面
    get '/users/check' => "users#check"
    # 退会処理（論理削除）
    patch '/users/withdraw' => "users#withdraw"
    # 検索機能
    get "search" => "searches#search"
  
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    # except destroyアクション以外のルーティングを作成
    resources :groups, except: [:destroy]
    end
    
    resources :users, only: [:show, :edit, :update]
  
  end
  
  # /favicon.icoへのリクエストを無視する
  get '/favicon.ico', to: ->(env) { [404, {}, []] }
  
end
