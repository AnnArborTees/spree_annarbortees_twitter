Spree::Core::Engine.add_routes do
  namespace :admin do
    resource :twitter_settings, :only => ['show', 'update', 'edit']
  end
end