class Address < ApplicationRecord
  validates :country, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }, format: {with: /[a-z]+/i, message:  I18n.t('model.invalid_format')}
  validates :street, length: { maximum: 255 }, format: {with: /[a-z]*/i, message:  I18n.t('model.invalid_format')}
  validates :building_number, presence: true, length: { maximum: 5 }
  validates :apartment_number, length: { maximum: 5 }
  validates :postal_code, presence: true
  validates_zipcode :postal_code
  validates :postal_code, zipcode: true


  def to_s
    street+" "+building_number.to_s+"/"+apartment_number.to_s+", "+postal_code+" "+city+", "+country
  end

  def country_alpha2
    if country.length > 0
      ISO3166::Country.find_by_name(country)[0]
    else
      nil
    end

  end


end
