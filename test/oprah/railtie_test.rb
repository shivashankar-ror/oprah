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
  end
end
