require 'bcrypt'
require './lib/dependency_injector'

module Controller
  # Controller to manage sites
  class Site
    extend DependencyInjector

    class << self
      def create(data)
        resource(:dataset_site).insert(name: data[:name], url: data[:url])
      end

      def list_all
        resource(:dataset_site).all
      end

      def get_users_from_site(site)
        site_id = resource(:dataset_site).where(name: site).first[:id]
        dataset = resource(:dataset_users_accounts)
                  .join(:users, id: :userID).where(siteID: site_id)
        users = []
        dataset.each do |r|
          users.push r[:name]
        end
        users
      end

      def register_site(reg)
        password = BCrypt::Password.create(reg[:password])
        resource(:dataset_users_accounts).insert(userName: reg[:userName],
                                                 password: password,
                                                 userID: user_id(reg[:user]),
                                                 siteID: site_id(reg[:site]))
      end

      def user_id(user)
        resource(:dataset_user).where(name: user).first[:id]
      end

      def site_id(site)
        resource(:dataset_site).where(name: site).first[:id]
      end
    end

    def by_id(id)
      resource(:dataset_site).where(id: id).first
    end

    def delete(id)
      resource(:dataset_site).where(id: id).delete
    end
  end
end
