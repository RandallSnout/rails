class Lender < ActiveRecord::Base
  has_secure_password
  has_many :histories

  validates :first_name, :last_name, :money, :presence => true
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => true
end
