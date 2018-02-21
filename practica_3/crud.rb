require_relative 'manage_services'
require_relative 'users'
require_relative 'sites'

# Abstract class to manage Crud of Database
class CRUD
  def initialize(table_class)
    @db = ManageServices.instance.db
    dataset = @db[table_class.table]
    @table_class = table_class.new(dataset)
  end

  def create(data)
    @table_class.insert data
  end

  def by_id(id)
    @table_class.by_id id
  end

  def list_all
    @table_class.consult
  end

  def delete(data)
    @table_class.delete data
  end
end
