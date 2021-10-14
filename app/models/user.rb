class User < ActiveRecord::Base

    validates :email, :username, uniqueness: true
    validates :email, :username, :avatar_url, :password, presence: true

end