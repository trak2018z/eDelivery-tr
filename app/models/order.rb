class Order < ApplicationRecord
  belongs_to :User
  has_many :packages
end
