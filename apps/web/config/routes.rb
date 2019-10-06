# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/cards', to: 'cards#index'
get '/qualify', to: 'qualify#index'
get '/qualify/new', to: 'qualify#new'
post '/qualify', to: 'qualify#create'
