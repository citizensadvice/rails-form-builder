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
    def cads_text_field(attribute, label: nil)
      label_text = label || object.class.human_attribute_name(attribute)

      component = CitizensAdviceComponents::TextInput.new(
        name: attribute,
        label: label_text,
        type: :text,
        options: {
          value: object.send(attribute),
          error_message: object.errors[attribute].first
        }
      )

      component.render_in(@template)
    end

    def cads_button(value = "Save changes")
      component = CitizensAdviceComponents::Button.new(type: :submit, variant: :primary)
      component.with_content(value)

      component.render_in(@template)
    end
  end
end
