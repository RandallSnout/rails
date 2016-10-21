class SessionsController < ApplicationController

	def new
	end

	def lender_reg
		user = Lender.new(lender_params)
	  	if user.save
	  		session[:user_id] = user.id
	  		redirect_to "/lenders/#{user.id}"
	  	else
	  		flash[:lender_errors] = user.errors.full_messages
	  	 	redirect_to :back
	  	end	
	end

	def borrower_reg
		user = Borrower.new(borrower_params)
	  	if user.save
	  		session[:user_id] = user.id
	  		redirect_to "/borrowers/#{user.id}"
	  	else
	  		flash[:borrower_errors] = user.errors.full_messages
	  	 	redirect_to :back
	  	end	
	end

	def login
	 	if user = Lender.find_by_email(params[:email])
		 	if user.authenticate(params[:password])
		 		session[:user_id] = user.id
		 		redirect_to "/lenders/#{user.id}"
		 	else
		 		flash[:error] = "Invalid Login"
		 		redirect_to :back
		 	end
		else user = Borrower.find_by_email(params[:email])
		 	if user.authenticate(params[:password])
		 		session[:user_id] = user.id
		 		redirect_to "/borrowers/#{user.id}"
		 	else
		 		flash[:error] = "Invalid Login"
		 		redirect_to :back
		 	end
		 end
	end

	def destroy
		reset_session
    	redirect_to action: "new"
	end

  private
	  def lender_params
	  	params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
	  end
	  def borrower_params
	  	params.require(:borrower).permit(:first_name, :last_name, :email, :password, :purpose, :description, :money, :raised)
	  end

end
