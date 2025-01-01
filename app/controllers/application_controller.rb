class ApplicationController < ActionController::Base
  before_action :configure_authentication

  private
  
  # 現在のコントローラーが管理者用かどうかに基づきメソッドを呼び出す
  def configure_authentication
    if admin_controller?
      autenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
  
  # 動いているコントローラーがAdminの名前空間の下にあればtrueを返す
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end
  
  # 特定のアクション(homes#top)の認証が不要であればtrueを返す
  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end
  
end
