Rails.application.routes.draw do


  #group / products
  get 'main' => 'shop#main', :as => :shop_main
  get 'farfalla' => 'shop#main', :as => :shop_farfalla
  get 'group/:link' => 'shop#group', :as => :shop_group
  get 'prod/:link' => 'shop#product', :as => :shop_product

  # cart
  match 'cart/add/:id' => 'shop#add', :as => :cart_add , :via => [:get,:post]
  get 'cart/remove/:id' => 'shop#remove', :as => :cart_remove

  # checkout + order
  get 'order' => 'shop#order', :as => :shop_order
  match 'checkout' => 'shop#checkout', :as => :shop_checkout , :via => [:get,:post]
  get "history" => "shop#history" , :as => :shop_history

  get 'welcome' => 'shop#welcome', :as => :shop_welcome
  get 'page/mailto' ,to: redirect("/")
  get 'page/liikkeemme' ,to: redirect("/")

  get 'page/:id' => 'shop#page', :as => :shop_page


  root :to => 'shop#main'
  get "/404", :to => "application#error"

  mount OfficeClerk::Engine => "/"

  resources :charges

  match '*path', via: :all, to: 'shop#error_404' #if Rails.production?

end
