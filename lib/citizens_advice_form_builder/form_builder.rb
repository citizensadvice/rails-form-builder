# frozen_string_literal: true

require "action_view"

module CitizensAdviceFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    def cads_text_field(attribute)
      @template.content_tag(:fieldset) do
        label(attribute) + text_field(attribute)
      end
    end

    def cads_button
      @template.submit_tag
    end
  end
end
