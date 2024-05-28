# frozen_string_literal: true

module CitizensAdviceFormBuilder
  module Elements
    class TextInput < Base
      def render
        component = CitizensAdviceComponents::TextInput.new(
          name: field_id,
          label: label,
          type: :text,
          width: options[:width],
          options: {
            hint: hint,
            optional: optional,
            value: current_value,
            error_message: error_message,
            additional_attributes: { name: field_name }
          }
        )

        component.render_in(@template)
      end
    end
  end
end
