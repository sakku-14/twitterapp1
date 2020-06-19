Rails.application.routes.draw do
  post 'likes/:id/create' => 'likes#create'
  post 'likes/:id/destroy' => 'likes#destroy'

  get 'users/index' => 'users#index'
  get 'users/new' => 'users#new'
  post 'users/new/create' => 'users#create'
  get 'users/login' => 'users#login'
  post 'users/login' => 'users#confirm'
  post 'users/logout' => 'users#logout'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'
  get 'users/:id/likes' => 'users#likes'
  get 'users/:id' => 'users#show'

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  post 'posts/new/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/delete' => 'posts#delete'
  post 'posts/:id/update' => 'posts#update'
  get 'posts/:id' => 'posts#show'

  get '/' => 'home#top'
  get 'about'=> 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
