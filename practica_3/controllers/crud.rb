require_relative '../manage_services'
require_relative 'users'
require_relative 'sites'
require_relative 'users_has_accounts'

# Abstract class to manage Crud of Database
class CRUD
  def initialize(table_class)
    @db = ManageServices.instance.db
    dataset = @db[table_class.table]
    @table_class = table_class.new(dataset)
  end

  def create(data)
    @table_class.create data
  end

  def by_id(id)
    @table_class.by_id id
  end

  def list_all
    @table_class.list_all
  end

  def delete(data)
    @table_class.delete data
  end

  def change_password(id, password)
    return false unless @table_class.respond_to? 'change_password'
    @table_class.change_password(id, password)
  end
end

# users = CRUD.new(Users)
# sites = CRUD.new(Sites)
# accounts = CRUD.new(UsersHasAccounts)

# Examples of create
# users.create({:name => 'Carlos',:userName => 'Carloselnegro',:email => 'Carlos@gmail.com'})
# sites.create({:name => 'youtube',:url => 'https://www.youtube.com'})
# accounts.create({:userName => 'Carloselnegro',:password => 'Carloselnegro',:userID => 21,:siteID => 13})
