Rails.application.routes.draw do
  resources :users
  resources :books do
    member do
      get :new_borrow
      patch :borrow
      get :new_return
      # patch :return
    end
  end

   root "users#index"
end
