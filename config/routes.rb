Rails.application.routes.draw do

  post 'authenticate', to: 'authentication#authenticate'

  resources :developers, format: false do
    resources :applications, format: false
  end
end
