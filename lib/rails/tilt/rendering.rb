require 'tilt/erb'

module Rails
  module Tilt
    module Rendering
      extend ActiveSupport::Concern
      include ActionView::ViewPaths

      # Render template to response_body
      # :api: public
      def render(*args, &block)
        super(*args, &block)

        options = _normalize_render(*args, &block)

        self.content_type ||= Mime[lookup_context.rendered_format].to_s
        self.response_body = ::Tilt.new("app/views/#{options[:prefixes].first}/#{options[:template]}.html.erb").render(:foo => "bar")
      end

      private

        # Normalize args and options.
        # :api: private
        def _normalize_render(*args, &block)
          options = _normalize_args(*args, &block)
          _normalize_options(options)
          options
        end

        # Normalize args by converting render "foo" to render :action => "foo" and
        # render "foo/bar" to render :file => "foo/bar".
        # :api: private
        def _normalize_args(action=nil, options={})
          options = super(action, options)
          case action
          when NilClass
          when Hash
            options = action
          when String, Symbol
            action = action.to_s
            key = action.include?(?/) ? :file : :action
            options[key] = action
          else
            options[:partial] = action
          end

          options
        end

        # Normalize options.
        # :api: private
        def _normalize_options(options)
          options = super(options)
          if options[:partial] == true
            options[:partial] = action_name
          end

          if (options.keys & [:partial, :file, :template]).empty?
            options[:prefixes] ||= _prefixes
          end

          options[:template] ||= (options[:action] || action_name).to_s
          options
        end
    end
  end
end
