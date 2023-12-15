# frozen_string_literal: true

require "action_view"

module CitizensAdviceFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def cads_text_field(attribute, label: nil)
      label_text = label

      @template.content_tag(:fieldset) do
        label(attribute, label_text) + text_field(attribute)
      end
    end

    def cads_button(value = "Save changes")
      @template.submit_tag(value)
    end
  end
end
