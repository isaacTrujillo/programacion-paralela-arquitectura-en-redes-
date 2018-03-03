# product class Sites fro factory class CRUD
class Sites
  def initialize(dataset)
    @dataset = dataset
  end

  def create(data)
    @dataset.insert(name: data[:name], url: data[:url])
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
    :sites
  end
end
