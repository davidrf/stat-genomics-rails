class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_one :root_directory_entry, -> { where(parent_id: nil) }, class_name: "DirectoryEntry", inverse_of: :user
  accepts_nested_attributes_for :root_directory_entry
end
