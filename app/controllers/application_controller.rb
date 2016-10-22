class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    if session[:lender_id]
      Lender.find(session[:lender_id]) if session[:lender_id]
    else
      Borrower.find(session[:borrower_id]) if session[:borrower_id]
    end
  end
  def require_correct_user
    if session[:lender_id]
      user = Lender.find(params[:id])
      redirect_to "/lenders/#{current_user.id}" if current_user != user
    else
      user = Borrower.find(params[:id]) 
      redirect_to "/borrowers/#{current_user.id}" if current_user != user
    end
  end
  def require_login
    redirect_to '/sessions/new' if session[:lender_id] == nil && session[:borrower_id] == nil
  end
  helper_method :current_user
end
