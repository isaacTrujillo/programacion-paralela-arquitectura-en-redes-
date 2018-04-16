require_relative 'lib/services'
require_relative 'controllers/user'
require_relative 'routes/users'
require_relative 'routes/repos'

require 'grape'
require 'json'
require 'ant'

require './lib/services'

# Main class to configure application
class GithubApi < Grape::API

  Service.configure!
  Controller::User.register(:table,Service.database[:users])
  Controller::User.register(:table_repos,Service.database[:repos])

  version 'v1', using: :header, vendor: 'UdeG'
  format :json
  prefix :api

  helpers Ant::Server::Response
  mount Routes::Users
  mount Routes::Repos
end
