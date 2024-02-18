# frozen_string_literal: true

require_relative "elements"

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
      Elements::TextInput.new(@template, object, attribute, label: label, required: required, hint: hint).render
    end

    def cads_button(value = "Save changes")
      component = CitizensAdviceComponents::Button.new(type: :submit, variant: :primary)
      component.with_content(value)

      component.render_in(@template)
    end
  end
end
