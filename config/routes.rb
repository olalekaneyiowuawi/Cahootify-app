Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :import_csvs, only: [:create, :new]
  root to: "import_movies#new"
end
