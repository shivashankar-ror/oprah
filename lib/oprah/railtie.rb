require 'rails/railtie'

module Oprah
  class Railtie < Rails::Railtie
    initializer "oprah.configure_cache_clear_on_code_reload" do
      ActiveSupport::Reloader.to_run do
        Oprah::Presenter.cache.clear

        if Oprah.debug?
          Rails.logger.debug "Oprah cache cleared"
        end
      end
    end

    initializer "oprah.configure_action_controller_helpers" do
      ActiveSupport.on_load :action_controller do
        ActionController::Base.include(Oprah::ControllerHelpers)
      end
    end
  end
end
