Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
   authenticated :user do
     root 'links#index', as: :authenticated_root
   end

   unauthenticated do
     root 'devise/registrations#new', as: :unauthenticated_root
   end
  end

  resources :links

  get '/:slug' => 'visits#create'

end
