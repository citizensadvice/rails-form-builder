# frozen_string_literal: true

class ExampleForm
  include ActiveModel::Model

  attr_accessor :name, :required_field

  validates :required_field, presence: true
end

RSpec.describe CitizensAdviceFormBuilder::FormBuilder do
  let(:controller) { ActionController::Base.new }
  let(:lookup_context) { ActionView::LookupContext.new(nil) }
  let(:template) { ActionView::Base.new(lookup_context, {}, controller) }

  let(:model) { ExampleForm.new(name: "Fred Flintstone") }
  let(:builder) { described_class.new(:example_form, model, template, {}) }

  let(:component_double) { instance_double(component, with_content: nil, render_in: nil) }

  before { allow(component).to receive(:new).and_return(component_double) }

  describe "#cads_button" do
    let(:component) { CitizensAdviceComponents::Button }

    it "calls the button component with default parameters" do
      builder.cads_button

      expect(component).to have_received(:new).with(type: :submit, variant: :primary)
      expect(component_double).to have_received(:with_content).with("Save changes")
    end

    it "calls the button component with a custom label text" do
      builder.cads_button "Next"

      expect(component_double).to have_received(:with_content).with("Next")
    end
  end

  describe "#cads_text_field" do
    let(:component) { CitizensAdviceComponents::TextInput }

    it "passes the attribute name to the text input component" do
      builder.cads_text_field(:name)

      expect(component).to have_received(:new).with(hash_including(name: "example_form_name"))
    end

    it "passes custom label text to the text input component" do
      builder.cads_text_field(:name, label: "First name")

      expect(component).to have_received(:new).with(hash_including(label: "First name"))
    end

    it "sets 'optional' to 'true' by default" do
      builder.cads_text_field(:name)

      expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: true)))
    end

    context "with 'required' parameter" do
      it "sets 'optional' to 'false' when true" do
        builder.cads_text_field(:name, required: true)

        expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: false)))
      end

      it "sets 'optional' to 'true' when false" do
        builder.cads_text_field(:name, required: false)

        expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: true)))
      end
    end
  end
end
