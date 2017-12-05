class Package < ApplicationRecord
  belongs_to :order
  belongs_to :cargo, optional: true

end
