class Address < ApplicationRecord
  belongs_to :user
  
  validates :zip, :street, :complement, :neighborhood, :city, :uf, presence: true
end
