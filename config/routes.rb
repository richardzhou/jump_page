JumpPage::Application.routes.draw do
  get "netldap/authenticate"  => "netldap#authenticate"
  post "netldap/authenticate" => "netldap#authenticate"
  get "netldap/add_entry" => "netldap#add_entry", :as => "add_entry"
  post "netldap/add_entry" => "netldap#add_entry"
  get "netldap/index"  => "netldap#index", :as => "index"
  post "netldap/index"  => "netldap#index"
  get "netldap/edit_entry"  => "netldap#edit_entry"
  post "netldap/edit_entry"  => "netldap#edit_entry"
  get "netldap/modify_entry" => "netldap#modify_entry"
  post "netldap/modify_entry"  => "netldap#modify_entry"
  get "netldap/search_entry"  => "netldap#search_entry", :as => "search_entry"
  post "netldap/search_entry"  => "netldap#search_entry", :as => "search_entry"
  get "netldap/delete_entry"  => "netldap#delete_entry"
  post "netldap/delete_entry"  => "netldap#delete_entry"
  resources :addressbooks
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'netldap#authenticate'
	#root :to => 'addressbooks#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
