Rails.application.routes.draw do
  # API definition
  namespace :api, default: { format: :json },
                          constraints: { subdomain: 'api'}, path: '/' do
    # Resources here
  end
end
