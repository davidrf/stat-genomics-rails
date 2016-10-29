Rails.application.routes.draw do
  api_version(
    module: "V1",
    header: { name: "Accept", value: Mime[:v1] },
    defaults: { format: :json }
  ) do
    resources :authentications, only: :create
    resources :users, only: [:show, :create]
    resources :folders, only: :show, controller: :directory_entries
    constraints AuthenticatedConstraint.new do
      resources :folders, only: :create, controller: :directory_entries
    end
  end
end
