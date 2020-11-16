class User < ApplicationRecord
  rolify  
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings

  def assign_default_role
    self.add_role(:client)
  end
  
end
