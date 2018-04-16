# Module created to implement dependency injection pattern
module DependencyInjector
  def resources
    @resources ||= {}
  end

  def register(key, value)
    resources[key] = value
  end

  def resource(key)
    res = resources[key]
    raise('Resource not found') if res.nil?
    res
  end
end
