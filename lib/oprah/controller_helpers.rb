module Oprah
  # Helpers that will be mixed into `ActionController::Base` by
  # the {Oprah::Railtie}.
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      helper_method :present
      helper_method :present_many
    end

    # Presents the given `object` using {Presenter.present}.
    #
    # Will pass the view context returned from {#oprah_view_context} to the
    # presenter.
    #
    # @param object [Object] The object to present
    # @param view_context [ActionView::Context] View context to assign
    # @return [Presenter] Presented object
    def present(object, view_context: oprah_view_context)
      Oprah.present(object, view_context: view_context)
    end

    # Presents the given `objects` using {Presenter.present}.
    #
    # Will pass the view context returned from {#oprah_view_context} to the
    # presenter.
    #
    # @param objects [Enumerable] The objects to present
    # @param view_context [ActionView::Context] View context to assign
    # @return [Presenter] Presented object
    def present_many(objects, view_context: oprah_view_context)
      Oprah.present_many(objects, view_context: view_context)
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
