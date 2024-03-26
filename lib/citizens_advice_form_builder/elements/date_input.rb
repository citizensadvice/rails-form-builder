# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    class DateInput < Base
      include ActionView::Helpers::TagHelper

      def render
        tag.div(class: form_field_classes) do
          safe_join([
            error_marker,
            tag.div(class: "cads-form-field__content") do
              tag.fieldset(class: "cads-form-group") do
                safe_join([legend_html, hint_html, error_message_html, date_inputs])
              end
            end
          ])
        end
      end

      private

      def legend_html
        tag.legend(class: "cads-form-field__label") { safe_join([label, optional_html]) }
      end

      def hint_html
        return if hint.nil?

        tag.p(class: "cads-form-field__hint") { hint }
      end

      def error_message_html
        return unless error_message.present?

        tag.p(class: "cads-form-field__error-message") { error_message }
      end

      def optional_html
        return unless optional

        tag.span(class: "cads-form-field__optional") { "(optional)" }
      end

      def date_inputs
        tag.div(class: "cads-date-input") do
          safe_join([day_input, month_input, year_input])
        end
      end

      def day_input
        component = CitizensAdviceComponents::TextInput.new(
          name: date_field_id("3i"),
          label: "Day",
          type: :number,
          width: :two_chars,
          options: {
            value: day_value,
            additional_attributes: { name: date_field_name("3i") }
          }
        )

        component.render_in(@template)
      end

      def month_input
        component = CitizensAdviceComponents::TextInput.new(
          name: date_field_id("2i"),
          label: "Month",
          type: :number,
          width: :two_chars,
          options: {
            value: month_value,
            additional_attributes: { name: date_field_name("2i") }
          }
        )

        component.render_in(@template)
      end

      def year_input
        component = CitizensAdviceComponents::TextInput.new(
          name: date_field_id("1i"),
          label: "Year",
          type: :number,
          width: :four_chars,
          options: {
            value: year_value,
            additional_attributes: { name: date_field_name("1i") }
          }
        )

        component.render_in(@template)
      end

      def date_field_name(suffix)
        @template.field_name(object_name, "#{attribute}(#{suffix})")
      end

      def date_field_id(suffix)
        "#{field_id}_#{suffix}"
      end

      def day_value
        current_value.day if current_value.is_a?(Date)
      end

      def month_value
        current_value.month if current_value.is_a?(Date)
      end

      def year_value
        current_value.year if current_value.is_a?(Date)
      end

      def error_marker
        return "" unless error_message.present?

        tag.div(class: "cads-form-field__error-marker")
      end

      def form_field_classes
        class_names("cads-form-field", "cads-form-field--has-error": error_message.present?)
      end
    end
  end
end
