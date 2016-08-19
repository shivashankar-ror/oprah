module Oprah
  # @since 0.1.2
  module TestHelpers
    def present_many(*args, **kwargs, &block)
      Oprah.present_many(*args, **kwargs, &block)
    end

    def present(*args, **kwargs, &block)
      Oprah.present(*args, **kwargs, &block)
    end
  end
end
