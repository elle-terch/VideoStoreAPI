Rails.application.routes.draw do


  get '/zomg', to: 'zomg#index'

  get '/customers', to: 'customers#index', as: 'customers'

  get '/movies', to: 'movies#index', as: 'movies'

  get '/movies/:id', to: 'movies#show', as: 'movie'

  post '/movies', to: 'movies#create'


  

  get '/rentals', to: 'rentals#index', as: 'rentals'

  get '/rentals/:id', to: 'rentals#show', as: 'rental'

  post '/rentals/check-out', to: 'rentals#checkout', as: 'checkout'

  post '/rentals/:id/check-in', to: 'rentals#checkin', as: 'checkin'




end
