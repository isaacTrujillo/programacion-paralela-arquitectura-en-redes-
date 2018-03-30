require 'grape'
require './lib/services'

Service.configure!

module Routes
  # Routes to auth request
  class Auth < Grape::API
    namespace :sites do
      route_param :site do
        # POST /api/sites/:site/auth
        post :auth do
          Controller::Auth.init(params[:site], params[:user], params[:password])
        end
      end
    end
  end
end
