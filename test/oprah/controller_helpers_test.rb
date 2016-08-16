require 'helper'

module Oprah
  class ControllerHelpersTest < Minitest::Test
    class Controller
      @@helper_methods = []

      class << self
        def helper_methods
          @@helper_methods
        end

        def helper_method(method)
          @@helper_methods << method
        end
      end

      def view_context
        :ok
      end

      include Oprah::ControllerHelpers
    end

    include Fixtures

    def setup
      super
      @controller = Controller.new
    end

    def test_present
      presenter = @controller.present(User.new)

      assert_kind_of UserPresenter, presenter
      assert_kind_of EntityPresenter, presenter

      assert_equal :ok, presenter.view_context
    end

    def test_present
      presenters = @controller.present_many([User.new, User.new])

      assert_equal 2, presenters.length

      presenters.each do |presenter|
        assert_equal "Foo Bar", presenter.name
        assert_equal :ok, presenter.view_context
      end
    end

    def test_present_custom_view_context
      presenter = @controller.present(User.new, view_context: :foobar)
      assert_equal :foobar, presenter.view_context
    end

    def test_helper_method
      assert_equal [:present, :present_many], Controller.helper_methods
    end

    def test_oprah_view_context
      assert_equal @controller.oprah_view_context, @controller.view_context
    end
  end
end
