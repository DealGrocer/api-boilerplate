require 'pathname'
require 'json'
require 'date'

module Application
  class << self
    def root(*dirs)
      @_root ||= File.expand_path('..', File.dirname(__FILE__))

      File.join @_root, *dirs
    end

    def environment
      return @_environment if defined? @_environment

      @_environment = (ENV['ENVIRONMENT'] || 'development').dup

      class << @_environment
        def method_missing(method, *args, &block)
          if method[-1] == '?'
            self == method[0..-2]
          else
            super
          end
        end
      end

      @_environment
    end
  end
end
