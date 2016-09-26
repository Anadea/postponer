require "waiter/version"

module Waiter
  class Waiter
    attr_accessor :executing_block

    def initialize(*available_methods, &block)
      self.executing_block = block

      if available_methods.empty?
        self.class.send(:define_method, :method_missing) do |m, *args, &block|
          executing_block.call().send(m, *args, &block)
        end
      else
        self.class.delegate(*available_methods, to: :executing_block_result)

        class << self
          def executing_block_result
            executing_block.call()
          end
        end
      end
    end
  end
end
