require 'ruby-enum'
module CommonMarker
  # For Ruby::Enum, these must be classes, not modules
  module Config
    class Parse
      include Ruby::Enum

      define :default, 0
      define :normalize, (1 << 8)
      define :validate_utf8, (1 << 9)
      define :smart, (1 << 10)
    end

    class Render
      include Ruby::Enum

      define :default, 0
      define :sourcepos, (1 << 1)
      define :hardbreaks, (1 << 2)
      define :safe, (1 << 3)
    end

    def self.process_options(option, type)
      type = Config.const_get(type.capitalize)
      if option.is_a?(Symbol)
        check_option(option, type)
        type.to_h[option]
      elsif option.is_a?(Array)
        option = [nil] if option.empty?
        # neckbearding around. the map will both check the opts and then bitwise-OR it
        option.map { |o| check_option(o, type); type.to_h[o] }.inject(0, :|)
      else
        raise TypeError, 'option type must be a valid symbol or array of symbols'
      end
    end

    def self.check_option(option, type)
      unless type.keys.include?(option)
        raise TypeError, "option ':#{option}' does not exist for #{type}"
      end
    end
  end
end
