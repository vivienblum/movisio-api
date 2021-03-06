require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
Bundler.require(*Rails.groups)

module MovisioApi
  class Application < Rails::Application
    config.api_only = true
    config.autoload_paths << Rails.root.join('lib')

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
      end
    end

    config.active_record.raise_in_transactional_callbacks = true
  end
end
