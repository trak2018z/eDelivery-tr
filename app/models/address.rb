class Address < ApplicationRecord
  belongs_to :user
  validates :country, presence: true, length: { maximum: 255 }
  validates :region, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :street, length: { maximum: 255 }
  validates :building_number, presence: true, length: { maximum: 255 }, numericality: true
  validates :apartment_number, length: { maximum: 255 }, numericality: true


  def to_s
    street+" "+building_number.to_s+"/"+apartment_number.to_s+", "+city+" - "+region+", "+country

  end
end
