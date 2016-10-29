class FileEntry < FileSystemEntry
  belongs_to :parent, class_name: DirectoryEntry
  belongs_to :user
  validates :name, presence: true
  validates :parent, presence: true
  validates :user, presence: true
end
