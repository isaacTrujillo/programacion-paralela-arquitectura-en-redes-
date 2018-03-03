require 'safe_yaml'
require 'sequel'

class Service

  def self.configure!
    load_config
  end

  def self.load_config!
    SafeYAML::OPTIONS[:default_mode] = :safe
    @config = SafeYAML.load_file('./config/config.yaml')
  end

  def self.database
    @database ||= Sequel.connect(@config['database']['endpoint'])
  end
end
