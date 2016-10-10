Rails.application.routes.draw do
  api_version(
    module: "V1",
    header: { name: "Accept", value: Mime[:v1] },
    defaults: { format: :json }
  ) do
    resources :users, only: [:show, :create]
  end
end
