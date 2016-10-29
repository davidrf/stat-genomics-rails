module V1
  class FileEntriesController < ApiController
    def create
      file_entry = FileEntry.new(file_entry_params)
      file_entry.user = current_user
      if file_entry.save
        render json: file_entry, status: :created
      else
        render json: file_entry.errors, status: :unprocessable_entity
      end
    end

    private

    def file_entry_params
      params.require(:file).permit(:name, :parent_id)
    end
  end
end
