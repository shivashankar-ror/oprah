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

    # Fails unless `object` is a presenter.
    #
    # @since 0.1.3
    # @param [Object] object The object to be tested
    # @return [Boolean]
    def assert_presented(object)
      msg = message(msg) do
        "Expected #{mu_pp(object)} to be an Oprah::Presenter"
      end

      assert object.kind_of?(Oprah::Presenter), msg
    end

    # Fails if `object` is a presenter.
    #
    # @since 0.1.3
    # @param [Object] object The object to be tested
    # @return [Boolean]
    def refute_presented(object)
      msg = message(msg) do
        "Expected #{mu_pp(object)} to not be an Oprah::Presenter"
      end

      refute object.kind_of?(Oprah::Presenter), msg
    end
  end
end
