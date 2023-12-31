# frozen_string_literal: true

class ExampleForm
  include ActiveModel::Model

  attr_accessor :name
end

RSpec.describe CitizensAdviceFormBuilder::FormBuilder do
  let(:controller) { ActionController::Base.new }
  let(:lookup_context) { ActionView::LookupContext.new(nil) }
  let(:helper) { ActionView::Base.new(lookup_context, {}, controller) }
  let(:object) { ExampleForm.new(name: "Fred Flintstone") }
  let(:builder) { described_class.new(:example_form, object, helper, {}) }

  describe "#cads_button" do
    it "renders a submit button" do
      result = builder.cads_button
      parsed_result = Nokogiri::HTML::DocumentFragment.parse(result)

      expect(parsed_result.at_css("input").attributes["value"].value).to eq "Save changes"
    end

    it "renders a submit button with a custom label" do
      result = builder.cads_button("Next")
      parsed_result = Nokogiri::HTML::DocumentFragment.parse(result)

      expect(parsed_result.at_css("input").attributes["value"].value).to eq "Next"
    end
  end

  describe "#cads_text_field" do
    it "renders a text field" do
      result = builder.cads_text_field(:name)
      parsed_result = Nokogiri::HTML::DocumentFragment.parse(result)

      expect(parsed_result.at_css("label").content).to eq "Name"
      expect(parsed_result.at_css("input").attributes["value"].value).to eq "Fred Flintstone"
    end

    it "renders a text field with a custom label" do
      result = builder.cads_text_field(:name, label: "First name")
      parsed_result = Nokogiri::HTML::DocumentFragment.parse(result)

      expect(parsed_result.at_css("label").content).to eq "First name"
    end
  end
end
