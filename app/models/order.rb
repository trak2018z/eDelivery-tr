class Order < ApplicationRecord
  belongs_to :user
  has_many :packages,  dependent: :destroy
  belongs_to :source_address, class_name: 'Address'
  belongs_to :target_address, class_name: 'Address'

  validates :receipt_date, presence: true
  validates :delivery_date, presence: true

  def price
    p = 0
    packages.each do |package|
      p += package.price
    end
    p
  end
  def date_to_picker
    self.receipt_date = self.receipt_date.strftime("%d/%m/%Y")
    self.delivery_date = self.delivery_date.strftime("%d/%m/%Y")
  end
end
