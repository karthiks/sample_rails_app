SampleApp::Application.routes.draw do
  root :to => 'pages#home'

  resources :users

  match '/about',   :to => 'pages#about'
  match '/contact', :to => 'pages#contact'
  match '/help',    :to => 'pages#help'
  match '/signup',  :to => 'users#new'
end
