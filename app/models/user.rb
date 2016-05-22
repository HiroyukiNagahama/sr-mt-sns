class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name,:code,:email
  validates_confirmation_of :password

  #
  def self.set_default
   User.create(code: 'hoge',email: 'h-nagahama@towatech.net',password: 'password',encrypted_password: 'password')
  end


end
