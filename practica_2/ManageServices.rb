require 'singleton'
require 'safe_yaml'
require 'sequel'

class ManageServices
  include Singleton

  def initialize
    configure!
  end

  def configure!
    data = YAML.load(File.open('./config/database.yml'), :safe => true)
    @DB = Sequel.
      connect(data['adapter']+'://'+data['username']+'@'+data['host']+'/'+data['database'])
  end

  def DB
    @DB
  end

end
