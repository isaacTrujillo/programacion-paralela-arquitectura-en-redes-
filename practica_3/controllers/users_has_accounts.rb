require 'bcrypt'

# product class UsersHasAccounts fro factory class CRUD
class UsersHasAccounts
  include BCrypt

  def initialize(dataset)
    @dataset = dataset
  end

  def create(reg)
    password = BCrypt::Password.create(reg[:password])
    @dataset.insert(userName: reg[:userName],
                    password: password,
                    userID: reg[:userID], siteID: reg[:siteID])
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

  def change_password(id, password)
    hashed_pass = BCrypt::Password.create(password)
    @dataset.where(id: id).update(password: hashed_pass)
  end

  def self.table
    :user_has_accounts
  end
end
