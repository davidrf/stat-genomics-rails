module V1
  class DirectoryEntriesController < ApiController
    def show
      directory_entry = DirectoryEntry.find(params[:id])
      render json: directory_entry
    end

    def create
      directory_entry = DirectoryEntry.new(directory_entry_params)
      directory_entry.user = current_user
      if directory_entry.save
        render json: directory_entry, status: :created
      else
        render json: directory_entry.errors, status: :unprocessable_entity
      end
    end

    private

    def directory_entry_params
      params.require(:folder).permit(:name, :parent_id)
    end
  end
end
