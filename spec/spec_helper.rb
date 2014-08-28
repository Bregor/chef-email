# Added by ChefSpec
require 'chefspec'
require 'chefspec/coverage'
require 'chefspec/berkshelf'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

ChefSpec::Coverage.start!

RSpec.configure do |config|
  # Specify the path for Chef Solo to find roles
  config.role_path = '../../roles'

  # Specify the Chef log_level (default: :warn)
  # config.log_level = :debug

  # Specify the path to a local JSON file with Ohai data
  # config.path = 'ohai.json'

  # Specify the operating platform to mock Ohai data from
  config.platform = 'ubuntu'

  # Specify the operating version to mock Ohai data from
  config.version = '12.04'
end
