module Oprah
  # @since 0.1.2
  module TestHelpers
    def present_many(*args, **kwargs)
      Oprah.present_many(*args, **kwargs)
    end

    def present(*args, **kwargs)
      Oprah.present(*args, **kwargs)
    end
  end
end
