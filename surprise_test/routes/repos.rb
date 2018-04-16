require 'grape'

require './controllers/repo'
require 'http'
require 'json'

module Routes
  class Repos < Grape::API
    namespace :repos do
      route_param :repo do
        route_param :username do
          namespace :home do
            post :clone do
              process_request do
                repo = HTTP.get("https://api.github.com/repos/#{params[:username]}/#{params[:repo]}").body
                repo = JSON.parse(repo)
                Controller::Repo.clone(repo["clone_url"])
              end
            end
          end
        end
      end
    end
  end
end
