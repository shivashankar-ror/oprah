module Oprah
  # A cache store to keep Object-to-Presenter mappings. This class is
  # thread-safe.
  class Cache
    def initialize
      @mutex = Mutex.new
      @mapping = {}
    end

    # Looks up presenters matching to `object` and stores them in the cache.
    #
    # @param object [Object] The presentable object
    # @return [Array] An array of Presenter classes
    def lookup(object)
      @mutex.synchronize do
        key = class_name_for(object)

        cached = @mapping[key]
        return cached if cached

        @mapping[key] = presenter_classes_for(object)
      end
    end

    # Clears the presenter cache.
    #
    # @return [Boolean]
    def clear!
      @mutex.synchronize do
        @mapping = {}
      end

      Rails.logger.debug "Oprah cache cleared." if Oprah.debug?

      true
    end

    private

    def presenter_classes_for(object)
      class_for(object).ancestors.map do |klass|
        begin
          (klass.name + "Presenter").constantize
        rescue NameError
        end
      end.compact.reverse
    end

    def class_name_for(object)
      class_for(object).name
    end

    def class_for(object)
      object.kind_of?(Class) ? object : object.class
    end
  end
end
