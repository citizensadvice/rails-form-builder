# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    module Collections
      class Select < Base
        include ActionView::Helpers::FormOptionsHelper

        def render
          component = CitizensAdviceComponents::Select.new(
            select_options: items,
            name: field_id,
            label: label,
            options: {
              hint: hint,
              optional: optional,
              error_message: error_message,
              value: current_value,
              additional_attributes: { name: field_name }
            }
          )

          component.render_in(@template)
        end

        private

        def items
          @options[:collection].map do |item|
            label = value_for_collection(item, text_method)
            value = value_for_collection(item, value_method)

            [label, value]
          end
        end

        def text_method
          @options[:text_method]
        end

        def value_method
          @options[:value_method] || text_method
        end
      end
    end
  end
end
