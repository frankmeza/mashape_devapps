class Developer < ApplicationRecord
  has_many :applications
  validates :username, :email, :password, presence: true
end
