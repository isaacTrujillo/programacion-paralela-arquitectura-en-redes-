require 'singleton'
require 'safe_yaml'
require 'sequel'

# Singleton class to manage database connection and instance
class ManageServices
  include Singleton

  def initialize
    configure!
  end

  def configure!
    data = YAML.safe_load(File.open('./config/database.yml'), safe: true)
    @db = Sequel
          .connect(data['adapter'] + '://' + data['username'] + '@' +
            data['host'] + '/' + data['database'])
  end

  attr_reader :db
end
