class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    if session[:user_id]
      Lender.find(session[:user_id]) 
    elsif session[:user_id]
      Borrower.find(session[:user_id])
    end
  end
  def require_correct_user
    if 
      user = Lender.find(params[:id])
    else 
      user = Borrower.find(params[:id]) 
    end
    redirect_to "/sessions/#{current_user.id}" if current_user != user
  end
  def require_login
    redirect_to '/sessions/new' if session[:user_id] == nil
  end
  helper_method :current_user
end
