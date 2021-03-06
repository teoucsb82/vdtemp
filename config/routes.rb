Viadeca::Application.routes.draw do
  devise_for :users
  root 'pages#index'

  namespace :admin do
    get '/' => 'dashboards#index'
    get '/charts' => 'dashboards#charts'
    resources :properties do
      resources :apartments, shallow: true do
        get '/photos' => 'apartments#photos'
        post '/photos' => 'apartments#add_photos'
        delete '/destroy_photo' => 'apartments#destroy_photo'
        resources :tenants, shallow: true
      end
    end
    resources :repairs
  end

  resources :pages, :only => [:index]
  resources :contacts, :only => [:index, :create]
  resources :background_checks, :only => [:create]
  resources :apartments do
    collection do
      post '/search' => 'apartments#search'
    end
  end
  get '/applications' => 'background_checks#new', as: 'new_background_check'

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
end
