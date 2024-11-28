Rails.application.routes.draw do
  get 'users/mypage'
  get 'users/edit'
  get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get 'about' => 'homes#about'
    
end
