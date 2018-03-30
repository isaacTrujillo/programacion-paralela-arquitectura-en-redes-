require 'grape'

require './controllers/site'

module Routes
  # Routes to site request
  class Sites < Grape::API
    namespace :sites do
      post do
        process_request do
          Controller::Site.create(name: params[:name], url: params[:url])
        end
      end

      get do
        process_request do
          Controller::Site.list_all
        end
      end

      route_param :site do
        post do
          Controller::Site.register_site(password: params[:password],
                                         userName: params[:userName],
                                         user: params[:user],
                                         site: params[:site])
        end

        get :users do
          Controller::Site.get_users_from_site(params[:site])
        end
      end
    end
  end
end
