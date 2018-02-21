# product class Sites fro factory class CRUD
class Sites
  def initialize(dataset)
    @dataset = dataset
  end

  def create(site)
    @dataset.insert(name: site[:name], url: site[:url])
  end

  def by_id(site_id)
    @dataset.where(id: site_id).first
  end

  def list_all
    @dataset.all
  end

  def delete(site_id)
    @dataset.where(id: site_id).delete
  end

  def self.table
    :sites
  end
end
