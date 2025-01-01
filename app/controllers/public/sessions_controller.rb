# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  
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

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
