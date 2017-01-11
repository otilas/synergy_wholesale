module SynergyWholesale
  class Inflector

    class << self

      # File activesupport/lib/active_support/inflector/methods.rb, line 89
      def underscore(camel_cased_word)
        return camel_cased_word unless camel_cased_word =~ /[A-Z-]|::/
        word = camel_cased_word.to_s.gsub('::'.freeze, '/'.freeze)
        word.gsub!(/(?:(?<=([A-Za-z\d]))|\b)(#{/(?=a)b/})(?=\b|[^a-z])/) { "#{$1 && '_'.freeze }#{$2.downcase}" }
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
        word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
        word.tr!('-'.freeze, '_'.freeze)
        word.downcase!
        word
      end

      # File activesupport/lib/active_support/inflector/methods.rb, line 206
      def demodulize(path)
        path = path.to_s
        if i = path.rindex('::')
          path[(i+2)..-1]
        else
          path
        end
      end

      # File activesupport/lib/active_support/inflector/methods.rb, line 257
      def constantize(camel_cased_word)
        names = camel_cased_word.split('::'.freeze)

        # Trigger a built-in NameError exception including the ill-formed constant in the message.
        Object.const_get(camel_cased_word) if names.empty?

        # Remove the first blank element in case of '::ClassName' notation.
        names.shift if names.size > 1 && names.first.empty?

        names.inject(Object) do |constant, name|
          if constant == Object
            constant.const_get(name)
          else
            candidate = constant.const_get(name)
            next candidate if constant.const_defined?(name, false)
            next candidate unless Object.const_defined?(name)

            # Go down the ancestors to check if it is owned directly. The check
            # stops when we reach Object or the end of ancestors tree.
            constant = constant.ancestors.inject do |const, ancestor|
              break const    if ancestor == Object
              break ancestor if ancestor.const_defined?(name, false)
              const
            end

            # owner is in Object, so raise
            constant.const_get(name, false)
          end
        end
      end

      def is_numeric?(string)
        !!Float(string.to_s) rescue false
      end

    end

  end
end
