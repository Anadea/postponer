require "postponer/version"
require "forwardable"

module Postponer
  extend self

  def defer(*available_methods, &block)
    if available_methods.empty?
      DelegateAll.new(&block)
    else
      DelegateSpecific.new(*available_methods, &block)
    end
  end

  alias_method :postpone, :defer

  class Base
    def initialize(&block)
      @block = block
    end

    def object
      defined?(@_object) ? @_object : @_object = @block.call
    end

    # Это костыль, потому что в Forwardable какой-то баг
    # Его вроде исправляли: https://bugs.ruby-lang.org/issues/12478
    # Но у меня в 2.3.1 он снова есть
    def method_defined?(name)
      methods.include?(name.to_sym)
    end
  end

  class DelegateSpecific < Base
    def initialize(*available_methods, &block)
      super(&block)
      extend SingleForwardable
      def_delegators :object, *available_methods
    end
  end

  class DelegateAll < Base
    def method_missing(*args, &block)
      object.public_send *args, &block
    end
  end
end
