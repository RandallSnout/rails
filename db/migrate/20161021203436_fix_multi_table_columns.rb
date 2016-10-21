class FixMultiTableColumns < ActiveRecord::Migration
  def change
  	rename_column :histories, :lenders_id, :lender_id
  	rename_column :histories, :borrowers_id, :borrower_id
  end
end
