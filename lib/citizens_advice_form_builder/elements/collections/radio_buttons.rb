# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    module Collections
      class RadioButtons < Base
        include ActionView::Helpers::FormOptionsHelper

        def render
          component = CitizensAdviceComponents::RadioGroup.new(
            legend: label,
            name: field_id,
            options: {
              hint: hint,
              optional: optional,
              error_message: error_message
            }
          )

          component.with_inputs(items)

          component.render_in(@template)
        end

        private

        def items
          @options[:collection].map do |item|
            label = value_for_collection(item, text_method)
            value = value_for_collection(item, value_method)
            checked = value.eql?(current_value)

            {
              name: field_name,
              label: label,
              value: value,
              checked: checked
            }
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
