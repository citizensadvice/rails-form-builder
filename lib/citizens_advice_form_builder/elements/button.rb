# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    class Button < Base
      def initialize(template, object, button_text: nil, **kwargs)
        super(template, object, nil, **kwargs)

        @button_text = button_text
      end

      def render
        component = CitizensAdviceComponents::Button.new(**options)
        component.with_content(@button_text)

        component.render_in(@template)
      end

      private

      def default_options
        { type: :submit, variant: :primary }
      end
    end
  end
end
