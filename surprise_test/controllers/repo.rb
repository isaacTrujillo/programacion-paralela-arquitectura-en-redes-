require './lib/dependency_injector'

module Controller
  class Repo
    class << self
      def clone(url)
        `git clone #{url}`
      end
    end
  end
end
