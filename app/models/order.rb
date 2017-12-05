class Order < ApplicationRecord
  belongs_to :user
  has_many :packages
  has_one :source_address, class_name: 'Address'
  has_one :target_address, class_name: 'Address'
end
