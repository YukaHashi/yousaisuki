# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  layout 'admin'
  
  protected
  
  # ログイン後の遷移先の設定
  def after_sign_in_path_for(resource)
    admin_dashboards_path
  end
  
  # ログアウト後の遷移先の設定
  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end
  
end
