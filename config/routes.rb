Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  post 'auth/steam/callback' => 'welcome#auth_callback'
  delete 'session' => 'welcome#session_logout'
  resources :players
end
