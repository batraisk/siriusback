# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  password           :string
#  encrypted_password :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord
	require 'digest'

	validates :password, confirmation: true
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,										
									  uniqueness: { case_sensitive: false },
                    format: { with: email_regex }

  before_save :encrypt_password

  def has_password?(submitted_password)
  	encrypted_password == encrypt(submitted_password)
  end

  def authenticate(email, submitted_password)
  	user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
 
  private
 
  def encrypt_password 
    self.salt = make_salt if new_record? 
    self.encrypted_password = encrypt(password) 
  end 

  def encrypt(string) 
    secure_hash("#{salt}--#{string}") 
  end 

  def make_salt 
    secure_hash("#{Time.now.utc}--#{password}") 
  end 

  def secure_hash(string) 
    Digest::SHA2.hexdigest(string) 
  end
end
