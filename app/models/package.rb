class Package < ApplicationRecord
  belongs_to :order
  belongs_to :cargo, optional: true

  validates :weight, presence: true, inclusion: 0..2000
  validates :length, presence: true, inclusion: 0..200
  validates :width, presence: true, inclusion: 0..200
  validates :height, presence: true, inclusion: 0..200

  def to_s
    "Size: #{height} x #{width} x #{length} cm, weight: #{weight} - price: #{ I18n.t('currency.short')} #{price}"
  end
  def size
    "#{height} x #{width} x #{length} cm"
  end
  def get_weight
    "#{weight} kg"
  end
end
