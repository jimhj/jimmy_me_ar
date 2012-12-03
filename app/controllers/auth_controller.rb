# coding: utf-8
class AuthController < ApplicationController
  before_filter :check_signed_in, :only => :sign_in
  before_filter :require_login, :only => :sign_out

  def sign_in
    if request.post?
      if params[:email] == Setting.admin_email && params[:password] == Setting.admin_pwd
        session[:admin_user] = "Jimmy"
      else
        flash[:error] = '邮箱或者密码不正确'
      end
      redirect_to :back
    end
    set_seo_meta('登录')    
  end

  def sign_out
    clear_login_state
    redirect_to root_path    
  end

  private

  def check_signed_in
    redirect_to :root if signed_in?
    return
  end  
end