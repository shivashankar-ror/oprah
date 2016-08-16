require 'helper'

module Oprah
  class Test < Minitest::Test
    def test_debug
      old = ENV["OPRAH_DEBUG"]

      ENV["OPRAH_DEBUG"] = nil
      refute Oprah.debug?

      ENV["OPRAH_DEBUG"] = "1"
      assert Oprah.debug?

      ENV["OPRAH_DEBUG"] = old
    end
  end
end
