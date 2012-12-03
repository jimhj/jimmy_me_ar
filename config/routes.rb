JimmyMeAr::Application.routes.draw do
  root :to => 'blogs#index', :as => :root

  resources :blogs, :except => :show
  match 'blogs/:slug' => 'blogs#show', :as => :blog, :via => :get
  match 'tags/:tag' => 'blogs#find_all_by_tag', :as => :tag, :via => :get
  match 'sign_in' => 'auth#sign_in', :as => :sign_in, :via => [:get, :post]
  match 'sign_out' => 'auth#sign_out', :as => :sign_out  
  # match ':controller(/:action(/:id))(.:format)'
end
