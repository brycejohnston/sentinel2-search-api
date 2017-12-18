class Product < ApplicationRecord
  has_many :tiles

  validates_uniqueness_of :name
  validates_uniqueness_of :path
end
