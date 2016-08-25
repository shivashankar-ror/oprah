require 'helper'

module Oprah
  class RailtieTest < Minitest::Test
    include Fixtures

    def test_cache_invalidation
      present User.new
      refute_nil Presenter.cache.fetch(User.name)
      Rails.application.reloader.reload!
      assert_nil Presenter.cache.fetch(User.name)
    end

    def test_controller_helper_inclusion
      assert_includes ActionController::Base, ControllerHelpers
      assert_includes ActionMailer::Base, ControllerHelpers
    end
  end
end
