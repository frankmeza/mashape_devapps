Rails.application.routes.draw do
  resources :developers, format: false do
    resources :applications, format: false
  end
end
