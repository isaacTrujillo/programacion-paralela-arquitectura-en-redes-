# product class UsersHasAccounts fro factory class CRUD
class UsersHasAccounts
  def initialize(dataset)
    @dataset = dataset
  end

  def create(reg)
    @dataset.insert(userName: reg[:userName],
                   password: reg[:password],
                   userID: reg[:userID], siteID: reg[:siteID])
  end

  def by_id(id)
    @dataset.where(id: id).first
  end

  def list_all
    @dataset.all
  end

  def delete(site_id)
    @dataset.where(id: site_id).delete
  end

  def self.table
    :user_has_accounts
  end
end
