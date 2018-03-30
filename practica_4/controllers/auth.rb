require './lib/dependency_injector'
require './controllers/site'
require 'jwt'
require 'bcrypt'

module Controller
  # Controller to manage authentication
  class Auth
    extend DependencyInjector

    class << self
      def init(site, user, password)
        @site = site
        @user = user
        @password = password
        validate
      end

      def validate
        validate_password
        message = { site: @site, user: @user }.to_json
        log_info('User login', user: @user, site: @site)
        payload = { data: message }
        token = JWT.encode payload, nil, 'none'
        { token: token }
      end

      private

      def validate_password
        # TODO: Connect to database and validate
        ex = Ant::Exceptions::AntFail.new(
          'Invalid credentials',
          'INVALID_CREDENTIALS'
        )
        raise(ex) unless BCrypt::Password.new(obtain_password) == @password
      end

      def obtain_password
        resource(:dataset_users_accounts).where(
          userID: Controller::Site.user_id(@user),
          siteID: Controller::Site.site_id(@site)
        ).first[:password]
      end
    end
  end
end
