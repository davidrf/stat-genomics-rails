class FileEntry < FileSystemEntry
  belongs_to :user
  validates :user, presence: true
end
