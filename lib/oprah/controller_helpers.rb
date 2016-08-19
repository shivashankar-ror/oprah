module Oprah
  # Helpers that will be mixed into `ActionController::Base` by
  # the {Oprah::Railtie}.
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      helper_method :present
      helper_method :present_many
    end

    # Presents a single object.
    #
    # Will pass the view context returned from {#oprah_view_context} to the
    # presenter by default. This can be overridden.
    #
    # @see Presenter.present
    def present(*args, **kwargs, &block)
      kwargs = { view_context: oprah_view_context }.merge(kwargs)
      Oprah.present(*args, **kwargs, &block)
    end

    # Presents a collection of objects.
    #
    # Will pass the view context returned from {#oprah_view_context} to the
    # presenter by default. This can be overridden.
    #
    # @see Presenter.present_many
    def present_many(*args, **kwargs, &block)
      kwargs = { view_context: oprah_view_context }.merge(kwargs)
      Oprah.present_many(*args, **kwargs, &block)
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
