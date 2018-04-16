require_relative 'main'

run Rack::Cascade.new [GithubApi.new]
