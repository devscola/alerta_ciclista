Rails.application.routes.draw do

  scope "(:locale)", locale: /es|en/ do
    resources :suggestions, except: :edit do
      resources :comments
    end

    root to: 'suggestions#index'
    post     '/suggestions/new'                                  => 'suggestions#create',                    as: 'create_suggestion'
    patch    '/suggestions/:id/edit'                             => 'suggestions#update',                    as: 'update_suggestion'
    get      '/suggestions/:id/edit/(:token)'                    => 'suggestions#edit',                      as: 'edit_suggestion'
    post     '/suggestions/:suggestion_id'                       => 'comments#create',                       as: 'create_comment'
    delete   '/suggestions/:suggestion_id/comments/:id/(:token)' => 'comments#destroy',                      as: 'delete_comment'
    get      '/suggestions/:suggestion_id/comments/:id/:token'   => 'comments#destroy'
    get      '/suggestion_validation/:token'                     => 'email_validation#suggestion_validation'
    get      '/comment_validation/:token'                        => 'email_validation#comment_validation'
    post     '/'                                                 => 'suggestions#index'
    get      '/comments/report/:id'                              => 'comments#report',                       as: 'report_comment'
    get      '/suggestions/report/:id'                           => 'suggestions#report',                    as: 'report_suggestion'
  end

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
