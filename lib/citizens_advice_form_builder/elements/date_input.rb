# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    class DateInput < Base
      def render
        tag.div(class: "cads-form-field") do
          tag.div(class: "cads-form-field__content") do
            tag.fieldset(class: "cads-form-group") do
              safe_join([legend_html, hint_html, date_inputs])
            end
          end
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
        tag.div(class: "cads-date-input") do
          tag.div(class: "cads-date-input__item") do
            tag.label(class: "cads-form-field__label", for: date_field_id("3i")) { "Day" } +
              tag.input(
                class: "cads-input cads-input--2ch",
                name: date_field_name("3i"),
                id: date_field_id("3i"),
                inputmode: "numeric",
                value: day_value
              )
          end
        end
      end

      def month_input
        tag.div(class: "cads-date-input") do
          tag.div(class: "cads-date-input__item") do
            tag.label(class: "cads-form-field__label", for: date_field_id("2i")) { "Month" } +
              tag.input(
                class: "cads-input cads-input--2ch",
                name: date_field_name("2i"),
                id: date_field_id("2i"),
                inputmode: "numeric",
                value: month_value
              )
          end
        end
      end

      def year_input
        tag.div(class: "cads-date-input") do
          tag.div(class: "cads-date-input__item") do
            tag.label(class: "cads-form-field__label", for: date_field_id("1i")) { "Year" } +
              tag.input(
                class: "cads-input cads-input--4ch",
                name: date_field_name("1i"),
                id: date_field_id("1i"),
                inputmode: "numeric",
                value: year_value
              )
          end
        end
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
    end
  end
end
