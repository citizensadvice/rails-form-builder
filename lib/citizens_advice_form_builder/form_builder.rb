# frozen_string_literal: true

require_relative "elements"

require "action_view"
require "citizens_advice_components"

require CitizensAdviceComponents::Engine.root.join("app", "lib", "citizens_advice_components", "fetch_or_fallback_helper")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "base")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "button")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "input")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "text_input")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "textarea")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "form_group")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "checkable", "base")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "checkable", "checkbox")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "checkable", "radio")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "checkbox_single")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "radio_group")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "error_summary")

module CitizensAdviceFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def cads_text_field(attribute, label: nil, hint: nil, required: false, **)
      Elements::TextInput.new(@template, object, attribute, label: label, required: required, hint: hint, **).render
    end

    def cads_text_area(attribute, label: nil, hint: nil, required: false, **)
      Elements::TextArea.new(@template, object, attribute, label: label, required: required, hint: hint, **).render
    end

    def cads_date_field(attribute, label: nil, hint: nil, required: false, **)
      Elements::DateInput.new(@template, object, attribute, label: label, required: required, hint: hint, **).render
    end

    def cads_collection_radio_buttons(attribute, label: nil, hint: nil, required: false, **)
      Elements::Collections::RadioButtons.new(@template, object, attribute, label: label, hint: hint, required: required, **).render
    end

    def cads_collection_check_boxes(attribute, label: nil, hint: nil, required: false, **)
      Elements::Collections::CheckBoxes.new(@template, object, attribute, label: label, hint: hint, required: required, **).render
    end

    def cads_collection_select(attribute, label: nil, hint: nil, required: false, **)
      Elements::Collections::Select.new(@template, object, attribute, label: label, hint: hint, required: required, **).render
    end

    def cads_button(button_text = "Save changes", **)
      Elements::Button.new(@template, object, button_text: button_text, **).render
    end

    def cads_error_summary
      Elements::ErrorSummary.new(@template, object, :unused).render
    end

    def cads_check_box(attribute, label: nil, **)
      Elements::CheckBox.new(@template, object, attribute, label: label, **).render
    end
  end
end
