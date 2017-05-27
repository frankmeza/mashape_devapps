class Application < ApplicationRecord
  belongs_to :developer
  validates :name, :key, :description, presence: true
end
