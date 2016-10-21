class LendersController < ApplicationController
  before_action :current_user, only:[:edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def show
  	@user = Lender.find(params[:id])
  	@freeloaders = Borrower.all
  	@lenders = Borrower.joins(:histories).select("first_name", "last_name", "description", "purpose", "money", "raised", "amount").all
  end

  def update
  	#pass in borrower id and current user to history with donate amount
  	lend = History.create(amount: params[:donate], lender_id: current_user.id, borrower_id: params[:id])
  	#take doante amount and subtract it from lender money and add to borrower money
	if current_user.money < params[:donate].to_i
		flash[:error] = "Too much money"
	else
		cashed = current_user.money - params[:donate].to_i
		fund = Borrower.find(params[:id])
		pay = fund.raised + params[:donate].to_i
		fund.update(raised: pay)
		current_user.update(money: cashed)
	end
  	redirect_to :back
  end
end
