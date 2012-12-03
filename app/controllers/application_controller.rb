# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :signed_in?
  
  def signed_in?
    session[:admin_user] == 'Jimmy'
  end
  
  def require_login
    unless signed_in?
      clear_login_state
      flash[:error] = '请登录后访问'
      redirect_to sign_in_path
    end
  end

  def clear_login_state
    session[:admin_user] = nil
    session.clear
  end

  def set_seo_meta(title = nil, meta_keywords = nil, meta_description = nil)
    default_keywords = %Q(Jimmy's Blog Ruby on Rails, Ruby, Rails, Jimmy)
    default_description = %Q(Jimmy's Blog Ruby on Rails, Ruby, Rails, Jimmy)
    @page_title = title || "Jimmy's Blog"    
    @keywords = meta_keywords || default_keywords
    @description = meta_description || default_description
  end   
    
end
