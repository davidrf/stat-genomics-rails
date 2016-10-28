class DirectoryEntrySerializer < ApplicationSerializer
  attributes :name

  belongs_to :user
  belongs_to :parent
  has_many :folders
  has_many :files

  def root
    "folder"
  end

  def folders
    object.children.directory_entries
  end

  def files
    object.children.file_entries
  end
end
