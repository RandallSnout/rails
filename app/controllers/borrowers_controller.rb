class BorrowersController < ApplicationController
  before_action :current_user, only:[:edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def show
  	@user = Borrower.find(params[:id])
  	@helpers = Lender.joins(:histories).select("first_name", "last_name", "email", "amount").where("#{@user.id} = borrower_id").all
  end
end
