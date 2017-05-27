class Developer < ApplicationRecord
  validates :username, :email, :password, presence: true
end
