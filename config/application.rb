require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Centurion
  class Application < Rails::Application
    # Expose our application's helpers to Administrate
    config.to_prepare do
      Administrate::ApplicationController.helper Centurion::Application.helpers
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end

    config.active_job.queue_adapter = :sidekiq
    config.application_name = Rails.application.class.parent_name
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.time_zone = 'Australia/Sydney'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
