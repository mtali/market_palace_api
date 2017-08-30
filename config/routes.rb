require 'api_constraints'

Rails.application.routes.draw do
  # API definition
  namespace :api, default: { format: :json },
                          constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resouces here
    end
  end
end
