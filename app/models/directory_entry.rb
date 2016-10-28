class DirectoryEntry < FileSystemEntry
  belongs_to :user

  validates :user, presence: true
end
