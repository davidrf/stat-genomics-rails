class DirectoryEntry < FileSystemEntry
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
end
