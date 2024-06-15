# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    module Collections
      class CheckBoxes < Base
        def render
          tag.div(class: form_field_classes) do
            safe_join([
              error_marker,
              tag.fieldset(class: "cads-form-field__content cads-form-group cads-form-group--checkbox") do
                safe_join([legend_html, hint_html, error_message_html, checkboxes_html])
              end
            ])
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

        # rubocop:disable Metrics/AbcSize
        def checkboxes_html
          checkboxes = items.map.with_index do |item, index|
            tag.div(class: "cads-form-group__item") do
              tag.input(
                class: "cads-form-group__input",
                type: "checkbox",
                id: item_id(index),
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
