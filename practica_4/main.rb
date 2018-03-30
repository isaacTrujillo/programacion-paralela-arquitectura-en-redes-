require_relative 'lib/services'
require_relative 'controllers/auth'
require_relative 'controllers/user'
require_relative 'controllers/site'
require_relative 'routes/auth'
require_relative 'routes/sites'

require 'grape'
require 'json'
require 'ant'

class AuthServer < Grape::API

  Controller::Site.register(:dataset_site, Service.database[:sites]);
  Controller::Site.register(:dataset_users_accounts, Service.database[:user_has_accounts]);
  Controller::Site.register(:dataset_user, Service.database[:users]);
  Controller::Auth.register(:dataset_users_accounts, Service.database[:user_has_accounts])

  version 'v1', using: :header, vendor: 'UdeG'
  format :json
  prefix :api

  helpers Ant::Server::Response
  mount Routes::Auth
  mount Routes::Sites

end
