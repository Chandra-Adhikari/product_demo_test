Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/demotest.com; version=1"}, :default => true) do
    resources :products, only: [:index, :show] do
      collection do
        get :purchases
      end
    end
  end
end
