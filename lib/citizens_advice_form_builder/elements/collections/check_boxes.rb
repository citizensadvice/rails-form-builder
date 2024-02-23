# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    module Collections
      class CheckBoxes < Base
        include ActionView::Helpers::FormOptionsHelper

        def render
          tag.div(class: "cads-form-field") do
            tag.fieldset(class: "cads-form-group") do
              safe_join([legend_html, hint_html, checkboxes_html])
            end
          end
        end

        private

        def items
          @options[:collection].map do |item|
            label = value_for_collection(item, text_method)
            value = value_for_collection(item, value_method)
            checked = Array(current_value).include?(value)

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

        def legend_html
          tag.legend(class: "cads-form-field__label") { safe_join([label, " ", optional_html]) }
        end

        def hint_html
          return if hint.nil?

          tag.p(class: "cads-form-field__hint") { hint }
        end

        def optional_html
          return unless optional

          tag.span(class: "cads-form-field__optional") { "(optional)" }
        end

        # rubocop:disable Metrics/AbcSize
        def checkboxes_html
          checkboxes = items.map.with_index do |item, index|
            tag.div(class: "cads-form-group__item") do
              tag.input(
                class: "cads-form-group__input",
                type: "checkbox",
                id: "#{field_id}-#{index}",
                name: "#{field_name}[]",
                value: item[:value],
                checked: item[:checked]
              ) +
                tag.label(class: "cads-form-group__label", for: "#{field_id}-#{index}") { item[:label] }
            end
          end

          safe_join(checkboxes)
        end
        # rubocop:enable Metrics/AbcSize
      end
    end
  end
end
