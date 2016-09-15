class OfferSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :status, :valid_until
  has_many :tasks
  has_many :contacts
  has_one :project
  has_many :notes
end
