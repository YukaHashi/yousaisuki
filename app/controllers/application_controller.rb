class ApplicationController < ActionController::Base
  # ログイン認証が済んでいない状態でトップページ以外にアクセスしても、ログイン画面へリダイレクトする
  before_action :authenticate_user!, except: [:top]
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にメソッド実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # サインイン後の遷移先を設定
  def after_sign_in_path_for(resource)
    users_mypage_path
  end
  
  # サインアウト後の遷移先を設定
  def after_sign_out_path_for(resource)
    root_path
  end
  
  protected
  
  # ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
