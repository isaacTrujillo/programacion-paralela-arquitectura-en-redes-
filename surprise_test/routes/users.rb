require 'grape'

require './controllers/user'
require 'http'
require 'json'

module Routes
  class Users < Grape::API
    namespace :users do
      route_param :username do
        post :update do
          process_request do
            user = HTTP.get("https://api.github.com/users/#{params[:username]}").body
            user = JSON.parse(user)
            Controller::User.update(user);
            repos = HTTP.get("https://api.github.com/users/#{params[:username]}/repos").body
            repos = JSON.parse(repos);
            Controller::User.update_repos(repos)
          end
        end
      end
    end
  end
end
