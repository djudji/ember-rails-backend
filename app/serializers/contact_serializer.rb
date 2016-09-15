class ContactSerializer < ActiveModel::Serializer
  attributes :id, :family_name, :given_name, :title, :phone, :email, :website, :address, :customer_id, :additional_info
  has_one :company
  has_many :notes
  has_many :projects
end
