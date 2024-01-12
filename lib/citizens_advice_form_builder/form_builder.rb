# frozen_string_literal: true

require "action_view"
require "citizens_advice_components"

require CitizensAdviceComponents::Engine.root.join("app", "lib", "citizens_advice_components", "fetch_or_fallback_helper")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "base")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "button")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "input")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "text_input")

module CitizensAdviceFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def cads_text_field(attribute, label: nil, hint: nil, required: false)
      label ||= object.class.human_attribute_name(attribute)

      optional = if required
                   false
                 else
                   true
                 end

      component = CitizensAdviceComponents::TextInput.new(
        name: id_for(attribute),
        label: label,
        type: :text,
        options: {
          hint: hint,
          optional: optional,
          value: object.send(attribute),
          error_message: error_message_for(attribute),
          additional_attributes: { name: name_for(attribute) }
        }
      )

      component.render_in(@template)
    end

    def cads_button(value = "Save changes")
      component = CitizensAdviceComponents::Button.new(type: :submit, variant: :primary)
      component.with_content(value)

      component.render_in(@template)
    end

    private

    def id_for(attribute)
      @template.field_id(object_name, attribute)
    end

    def name_for(attribute)
      @template.field_name(object_name, attribute)
    end

    def error_message_for(attribute)
      object.errors[attribute].first
    end
  end
end
