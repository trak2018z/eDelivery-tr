class Order < ApplicationRecord
  belongs_to :user
  has_many :packages,  dependent: :destroy
  belongs_to :source_address, class_name: 'Address'
  belongs_to :target_address, class_name: 'Address'

  validates :receipt_date, presence: true
  validates :delivery_date, presence: true
  validate :addresses_presence

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
  def addresses_presence
    if source_address.nil?
      errors.add(:source_address_id, "can't be blank.")
      errors.delete(:source_address)
    end
    if target_address.nil?
      errors.add(:target_address_id, "can't be blank.")
      errors.delete(:target_address)
    end
    false if target_address.nil? or source_address.nil?
  end

end
