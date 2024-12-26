class SessionsController < ApplicationController
  before_action :reject_user, only: [:create]
  
  protected
  
  def reject_end_user
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end
  
  # ログイン後の遷移先の設定
  def after_sign_in_path_for(resource)
    admin_dashboards_path
  end
  
  # ログアウト後の遷移先の設定
  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end
  
end
