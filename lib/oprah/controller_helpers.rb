module Oprah
  # Helpers that will be mixed into `ActionController::Base` by
  # the {Oprah::Railtie}.
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      helper_method :present
      helper_method :present_many
    end

    # Shortcut to {Presenter.present}.
    #
    # Will pass the view context returned from {#oprah_view_context} to the
    # presenter by default. This can be overridden.
    def present(*args, **kwargs)
      kwargs = { view_context: oprah_view_context }.merge(kwargs)
      Oprah.present(*args, **kwargs)
    end

    # Shortcut to {Presenter.present_many}.
    #
    # Will pass the view context returned from {#oprah_view_context} to the
    # presenter by default. This can be overridden.
    def present_many(*args, **kwargs)
      kwargs = { view_context: oprah_view_context }.merge(kwargs)
      Oprah.present_many(*args, **kwargs)
    end

    # The view context automatically passed to presented objects.
    #
    # You can override this method pass a custom view context to all
    # presented objects from the controller scope.
    #
    # @return [ActionView::Context]
    def oprah_view_context
      view_context
    end
  end
end
