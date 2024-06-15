# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    module Collections
      class CheckBoxes < Base
        include ActionView::Helpers::FormOptionsHelper

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

        def error_message_html
          return unless error?

          tag.p(class: "cads-form-field__error-message") { error_message }
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

        def item_id(index)
          if index.zero?
            "#{field_id}-input"
          else
            "#{field_id}-#{index}"
          end
        end

        def error_marker
          return "" unless error?

          tag.div(class: "cads-form-field__error-marker")
        end

        def form_field_classes
          class_names("cads-form-field", "cads-form-field--has-error": error?)
        end

        def error?
          error_message.present?
        end
      end
    end
  end
end
