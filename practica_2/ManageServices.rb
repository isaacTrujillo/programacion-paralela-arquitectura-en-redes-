require 'singleton'
require 'safe_yaml'

class ManageServices
  include Singleton

  def configure!
    YAML.load("./config/config.yaml", :safe => true)
  end
end

puts ManageServices.instance
ManageServices.instance.configure!()
