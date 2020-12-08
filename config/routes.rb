Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Scopping module on routes, to have better routing name
  scope module: 'api' do
    scope module: 'v1' do
      namespace :user do
        resources :test_instances, only: %i[create index]
      end
    end
  end

end
