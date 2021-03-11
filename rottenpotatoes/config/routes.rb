Rottenpotatoes::Application.routes.draw do
  # resources :movies
  # map '/' to be a redirect to '/movies'
  root 'movies#index'
  
  resources :movies do
    get :similar_movies
  end
end
