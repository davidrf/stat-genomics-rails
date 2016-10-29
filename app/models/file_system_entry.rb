class FileSystemEntry < ApplicationRecord
  has_closure_tree dependent: :destroy, order: "name"
  scope :directory_entries, -> { where(type: "DirectoryEntry") }
  scope :file_entries, -> { where(type: "FileEntry") }
end
