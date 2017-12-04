class Cargo < ApplicationRecord
  belongs_to :transporter
  has_many :packages
end
