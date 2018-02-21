# product class Users for factory class CRUD
class Users

  def initialize(dataset)
    @dataset = dataset
  end

  def create(data)
    @dataset.insert(name: data[:name], userName: data[:userName],
                   email: data[:email])
  end

  def by_id(id)
    @dataset.where(id: id).first
  end

  def list_all
    @dataset.all
  end

  def delete(id)
    @dataset.where(id: id).delete
  end

  def self.table
    :users
  end
end
