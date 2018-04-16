require './lib/dependency_injector'
require 'cute_logger'

module Controller
  class User
    extend DependencyInjector
    class << self
      def update(user)
        resource(:table).insert(ID: user["id"],login: user["login"],url: user["url"],
          html_url: user["html_url"],repos_url: user["repos_url"],type: user["type"],
          name: user["name"],company: user["company"])
      end

      def update_repos(repos)
        repos.each do |repo|
          owner = repo["owner"]
          resource(:table_repos).insert(ID: repo["id"],name: repo["name"],
            full_name: repo["full_name"],user_id: owner["id"])
        end
      end
    end
  end
end
