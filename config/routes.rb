Car::Application.routes.draw do
  root 'index#index'
  get "index/index"
  get "index/login"
  get "index/logout"
  get "index/nopower"
  post "index/checklogin"
  get "index/changepwd"
  post "index/savechangepwd"

  get 'series/ajax_search'

  get "depot/index"
  post "depot/add"

  get "sell/index"
  post "sell/add"

  get "selloff/index"
  post "selloff/add"
  get "selloff/new"
  get "selloff/edit"
  patch "selloff/update"
  delete "selloff/destroy"

  get 'dy/index'
  post 'dy/dy_start'
  post 'dy/dy_end'

  resources :brands do
    resources :series
  end

  resources :assessments


  get "car_infos/search"

  resources :car_infos

  resources :photos

  resources :repairs do
    member do
      post 'check'
    end
  end

  get "customers/followups"

  resources :customers do
    resources :followups, :controller => "customer_followups"
  end

  resources :car_infos do
    resources :followups, :controller => "car_info_followups" do
      get 'cancel'
      post 'save_cancel'
    end
  end

  resources :payments

  resources :proceeds

  resources :profits

  resources :departments

  resources :cdepots

  resources :users

  resources :price_refs
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  mount ChinaCity::Engine => '/china_city'
end
