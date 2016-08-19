module Oprah
  # Test helpers that can be included into `Minitest::Test` or
  # `ActiveSupport::TestCase`.
  #
  # @since 0.1.2
  module TestHelpers
    # Presents a collection of objects.
    #
    # @see Presenter.present_many
    def present_many(*args, **kwargs, &block)
      Presenter.present_many(*args, **kwargs, &block)
    end

    # Presents a single object.
    #
    # @see Presenter.present
    def present(*args, **kwargs, &block)
      Presenter.present(*args, **kwargs, &block)
    end
  end
end
