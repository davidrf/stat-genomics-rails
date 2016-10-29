class UserSerializer < ApplicationSerializer
  attributes :email, :root_folder_id

  def root_folder_id
    object.root_directory_entry && object.root_directory_entry.id
  end
end
