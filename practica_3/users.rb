# product class Users fro factory class CRUD
class Users
  def initialize(dataset)
    @dataset = dataset
  end

  def create(user)
    @dataset.insert(name: user[:name], userName: user[:userName],
                    email: user[:email])
  end

  def by_id(user_id)
    @dataset.where(id: user_id).first
  end

  def list_all
    @dataset.all
  end

  def delete(user_id)
    @dataset.where(id: user_id).delete
  end

  def self.table
    :users
  end
end
