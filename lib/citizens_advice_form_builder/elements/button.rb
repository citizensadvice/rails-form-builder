# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    class Button < Base
      def initialize(template, object, button_text: nil, icon_left: nil, icon_right: nil, **kwargs)
        super(template, object, nil, **kwargs)

        @button_text = button_text
        @icon_left = icon_left
        @icon_right = icon_right
      end

      def render
        component = CitizensAdviceComponents::Button.new(**options)
        component.with_content(@button_text)

        if @icon_left
          component.with_icon_left do
            icon_left_class.new.render_in(@template)
          end
        end

        if @icon_right
          component.with_icon_right do
            icon_right_class.new.render_in(@template)
          end
        end

        component.render_in(@template)
      end

      private

      def default_options
        { type: :submit, variant: :primary }
      end

      def icon_left_class
        "CitizensAdviceComponents::Icons::#{@icon_left.to_s.camelize}".constantize
      end

      def icon_right_class
        "CitizensAdviceComponents::Icons::#{@icon_right.to_s.camelize}".constantize
      end
    end
  end
end
