class FileEntrySerializer < ApplicationSerializer
  attributes :name

  belongs_to :user
  belongs_to :parent

  def root
    "file"
  end
end
