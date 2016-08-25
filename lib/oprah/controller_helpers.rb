module Oprah
  # Helpers that will be mixed into `ActionController::Base` and
  # `ActionMailer::Base` by the {Oprah::Railtie}.
  module ControllerHelpers
    # A proxy class to delegate method calls to view contexts in presenters
    # to the most recently created view context by
    # {ControllerHelpers#view_context}.
    #
    # `ViewContextProxy` objects are automatically created in
    # {ControllerHelpers#present} and {ControllerHelpers#present_many} and
    # shouldn't have to be created manually.
    #
    # @since 0.1.3
    class ViewContextProxy < ActiveSupport::ProxyObject
      # @param [ActionController::Base] controller
      #   The controller to delegate to.
      def initialize(controller)
        @controller = controller
      end

      # Delegates all method calls to the `ActionView::Base` returned from
      # {ControllerHelpers#oprah_view_context}.
      def method_missing(meth, *args, &block)
        @controller.oprah_view_context.__send__(meth, *args, &block)
      end
    end

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
      kwargs = {
        view_context: oprah_view_context_proxy
      }.merge(kwargs)

      Presenter.present(*args, **kwargs, &block)
    end

    # Presents a collection of objects.
    #
    # Will pass the view context returned from {#oprah_view_context} to the
    # presenter by default. This can be overridden.
    #
    # @see Presenter.present_many
    def present_many(*args, **kwargs, &block)
      kwargs = {
        view_context: oprah_view_context_proxy
      }.merge(kwargs)

      Presenter.present_many(*args, **kwargs, &block)
    end

    # The view context automatically passed to objects presented from this
    # controller.
    #
    # You can override this method pass a custom view context to all
    # presented objects from the controller scope.
    #
    # @see #oprah_view_context=
    # @return [ActionView::Base]
    def oprah_view_context
      @oprah_view_context || view_context
    end

    # Assigns the view context returned from {#oprah_view_context}.
    #
    # You can override this method pass a custom view context to all
    # presented objects from the controller scope.
    #
    # @since 0.1.3
    # @see #oprah_view_context
    # @param [ActionView::Base] view_context The view context to assign
    # @return [ActionView::Base]
    def oprah_view_context=(view_context)
      @oprah_view_context = view_context
    end

    # Returns an instance of a view class and sets the current view context
    # returned by {#oprah_view_context}.
    #
    # If you override this method in your controller ensure you keep Oprah's
    # view context updated using {#oprah_view_context=}.
    #
    # @since 0.1.3
    # @see http://api.rubyonrails.org/classes/ActionView/Rendering.html#method-i-view_context
    #      Rails API Documentation
    # @return [ActionView::Base]
    def view_context
      self.oprah_view_context = super
    end

    private

    # @since 0.1.3
    def oprah_view_context_proxy
      @oprah_view_context_proxy ||= ViewContextProxy.new(self)
    end
  end
end
