# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    class Base
      attr_reader :template, :object, :attribute, :options

      def initialize(template, object, attribute, **kwargs)
        @template = template
        @object = object
        @attribute = attribute

        @options = kwargs.with_defaults(default_options)
      end

      def render
        # NO OP
      end

      private

      def current_value
        object.send(attribute)
      end

      def default_options
        {}
      end

      def error_message
        object.errors[attribute]&.first
      end

      def object_name
        object.to_model.model_name.singular
      end

      def field_name
        template.field_name(object_name, attribute)
      end

      def field_id
        template.field_id(object_name, attribute)
      end

      def label
        options[:label] || object.class.human_attribute_name(attribute)
      end

      def hint
        options[:hint]
      end

      def optional
        !!!options[:required]
      end
    end
  end
end
