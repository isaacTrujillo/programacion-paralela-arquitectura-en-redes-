require 'bcrypt'

module Controller
  class Site
    extend DependencyInjector

    class << self
      def create(data)
        @dataset.insert(name: data[:name], url: data[:url])
      end

      def list_all
        @dataset.all
      end

      def get_users_from_site(site)
        site_id = Services.database[:sites].where(name: site).first[:id]
        dataset = Services.database[:user_has_accounts]
                                .join(:users, id: :userID).where(siteID: site_id)
        users = []
        dataset.each do |r|
          users.push r[:name]
        end
        users
      end

      def register(reg)
        password = BCrypt::Password.create(reg[:password])
        Services.database[:users_has_accounts].insert(userName: reg[:userName],
                        password: password,
                        userID: reg[:userID], siteID: reg[:siteID])
      end
    end

    def initialize(dataset)
      @dataset = dataset
    end

    def by_id(id)
      @dataset.where(id: id).first
    end

    def delete(id)
      @dataset.where(id: id).delete
    end

    def self.table
      :sites
    end
  end
end
