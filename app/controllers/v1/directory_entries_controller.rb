module V1
  class DirectoryEntriesController < ApiController
    def show
      directory_entry = DirectoryEntry.find(params[:id])
      render json: directory_entry
    end
  end
end
