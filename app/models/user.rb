class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def self.search(search)
    where("email LIKE ? OR 'firstName' LIKE ? OR 'lastName' LIKE ?",
    "%#{search}%", "%#{search}%", "%#{search}%") 
  end
end
