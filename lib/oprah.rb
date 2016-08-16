# stdlib
require 'singleton'

# gems
require 'active_support/concern'
require 'active_support/inflector'
require 'action_controller'

# internal
require 'oprah/cache'
require 'oprah/controller_helpers'
require 'oprah/presenter'
require 'oprah/version'

require 'oprah/railtie' if defined?(Rails)

# The Oprah namespace.
module Oprah
  # @!visibility private
  def debug?
    !!ENV["OPRAH_DEBUG"]
  end

  # Shortcut to {Oprah::Presenter#present}.
  #
  # @param object [Object] The object to present
  # @param view_context [ActionView::Context] View context to assign
  # @return [Presenter] Presented object
  def present(object, view_context: Presenter.default_view_context)
    Presenter.present(object, view_context: view_context)
  end

  # Shortcut to {Presenter#present_many}.
  #
  # @param objects [Enumerable] The objects to present
  # @param view_context [ActionView::Context] View context to assign
  # @return [Enumerable] Presented collection
  def present_many(objects, view_context: Presenter.default_view_context)
    Presenter.present_many(objects, view_context: view_context)
  end

  extend self
end
