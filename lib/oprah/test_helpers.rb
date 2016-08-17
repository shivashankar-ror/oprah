module Oprah
  module TestHelpers
    def present_many(*args, &block)
      Oprah.present_many(*args, &block)
    end

    def present(*args, &block)
      Oprah.present(*args, &block)
    end
  end
end
