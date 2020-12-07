class Address < ApplicationRecord
  belongs_to :user
  
  validates :zip, :street, :complement, :neighborhood, :city, :uf, presence: true
  validates :zip, uniqueness: true
end
