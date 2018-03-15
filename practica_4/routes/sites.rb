require 'grape'
require './controller/site'

module Routes
  class Sites < Grape:API
    namespace :sites do
      post do
        process_request do
          Controller::Site.create(){:name => params[:name],:url => params[:url]})
        end
      end

      get do
        process_request do
          Controller::Site.list_all
        end
      end

      route_param :site do

        post :users do
        end

      end
    end
  end
end
