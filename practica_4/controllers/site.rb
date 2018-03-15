module Controller
  class Site

    class << self
      def create(data)
        @dataset.insert(name: data[:name], url: data[:url])
      end

      def list_all
        @dataset.all
      end
    end

    def initialize(dataset)
      @dataset = dataset
    end

    def by_id(id)
      @dataset.where(id: id).first
    end

    def delete(id)
      @dataset.where(id: id).delete
    end

    def self.table
      :sites
    end
  end
end
