# frozen_string_literal: true

require "action_view"
require "citizens_advice_components"

require CitizensAdviceComponents::Engine.root.join("app", "lib", "citizens_advice_components", "fetch_or_fallback_helper")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "base")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "button")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "input")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "text_input")
require CitizensAdviceComponents::Engine.root.join("app", "components", "citizens_advice_components", "textarea")

module CitizensAdviceFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::FormOptionsHelper

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

    def cads_text_area(attribute, label: nil, hint: nil, required: false, rows: nil)
      label ||= object.class.human_attribute_name(attribute)

      optional = if required
                   false
                 else
                   true
                 end

      component = CitizensAdviceComponents::Textarea.new(
        name: id_for(attribute),
        label: label,
        rows: rows,
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

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def cads_collection_radio_buttons(attribute, collection, value_method, text_method = nil, legend: nil)
      legend ||= object.class.human_attribute_name(attribute)
      text_method ||= value_method
      current_value = object.send(attribute)

      items = collection.map do |item|
        # From ActionView::FormOptionsHelper
        label = value_for_collection(item, text_method)
        value = value_for_collection(item, value_method)

        checked = value.eql?(current_value)

        { name: name_for(attribute), label: label, value: value, checked: checked }
      end

      component = CitizensAdviceComponents::RadioGroup.new(
        legend: legend,
        name: id_for(attribute)
      )

      component.with_inputs(items)

      component.render_in(@template)
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

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
