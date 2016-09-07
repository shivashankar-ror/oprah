# stdlib
require 'delegate'

# gems
require 'active_support/cache'
require 'active_support/concern'
require 'active_support/inflector'
require 'active_support/proxy_object'
require 'action_controller'

# internal
require 'oprah/controller_helpers'
require 'oprah/presenter'
require 'oprah/version'

require 'oprah/railtie' if defined?(Rails)

# The Oprah namespace.
#
# @since 0.0.1
module Oprah
  # @!visibility private
  def debug?
    !!ENV["OPRAH_DEBUG"]
  end

  # Presents a single object.
  #
  # @see Presenter.present
  def present(*args, **kwargs, &block)
    Presenter.present(*args, **kwargs, &block)
  end

  # Presents a collection of objects.
  #
  # @see Presenter.present_many
  def present_many(*args, **kwargs, &block)
    Presenter.present_many(*args, **kwargs, &block)
  end

  extend self
end

