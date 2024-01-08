# frozen_string_literal: true

class ExampleForm
  include ActiveModel::Model

  attr_accessor :name, :required_field, :description, :favourite_drink

  validates :required_field, presence: true
end

RSpec.describe CitizensAdviceFormBuilder::FormBuilder do
  let(:controller) { ActionController::Base.new }
  let(:lookup_context) { ActionView::LookupContext.new(nil) }
  let(:template) { ActionView::Base.new(lookup_context, {}, controller) }

  let(:model) { ExampleForm.new(name: "Fred Flintstone", description: "Lorem ipsum", favourite_drink: "0002") }
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

    it "passes the attribute's existing value to the text input component" do
      builder.cads_text_field(:name)

      expect(component).to have_received(:new).with(hash_including(options: hash_including(value: "Fred Flintstone")))
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

    context "with 'hint' parameter" do
      it "passes hint to the text input component" do
        builder.cads_text_field(:name, hint: "Example hint")

        expect(component).to have_received(:new).with(hash_including(options: hash_including(hint: "Example hint")))
      end
    end

    context "when there is a validation error" do
      it "sets 'error_message'" do
        model.errors.add(:name, :example, message: "example error")

        builder.cads_text_field(:name)

        expect(component).to have_received(:new).with(hash_including(options: hash_including(error_message: "example error")))
      end
    end
  end

  describe "#cads_text_area" do
    let(:component) { CitizensAdviceComponents::Textarea }

    it "passes the attribute name to the text input component" do
      builder.cads_text_area(:description)

      expect(component).to have_received(:new).with(hash_including(name: "example_form_description"))
    end

    it "passes the attribute's existing value to the text input component" do
      builder.cads_text_area(:description)

      expect(component).to have_received(:new).with(hash_including(options: hash_including(value: "Lorem ipsum")))
    end

    it "sets 'optional' to 'true' by default" do
      builder.cads_text_area(:description)

      expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: true)))
    end

    context "with 'required' parameter" do
      it "sets 'optional' to 'false' when true" do
        builder.cads_text_area(:description, required: true)

        expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: false)))
      end

      it "sets 'optional' to 'true' when false" do
        builder.cads_text_area(:description, required: false)

        expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: true)))
      end
    end

    context "with 'hint' parameter" do
      it "passes hint to the text area component" do
        builder.cads_text_area(:description, hint: "Example hint")

        expect(component).to have_received(:new).with(hash_including(options: hash_including(hint: "Example hint")))
      end
    end

    context "with 'rows' parameter" do
      it "passes rows to the text area component" do
        builder.cads_text_area(:description, rows: 5)

        expect(component).to have_received(:new).with(hash_including(rows: 5))
      end
    end

    context "when there is a validation error" do
      it "sets 'error_message'" do
        model.errors.add(:description, :presence, message: "Description is required")

        builder.cads_text_area(:description)

        expect(component).to have_received(:new).with(hash_including(options: hash_including(error_message: "Description is required")))
      end
    end
  end

  describe "#cads_collection_radio_buttons" do
    let(:component) { CitizensAdviceComponents::RadioGroup }
    let(:component_double) { instance_double(component, with_inputs: nil, render_in: nil) }

    let(:drink) { Struct.new(:reference, :colour, :name) }
    let(:collection) do
      [
        drink.new("0001", "Light Brown", "Tea"),
        drink.new("0002", "Dark Brown", "Coffee"),
        drink.new("9999", "Clear", "Water")
      ]
    end

    it "passes the attribute name to the radio group component" do
      builder.cads_collection_radio_buttons(:favourite_drink, collection, :reference, :name)

      expect(component).to have_received(:new).with(hash_including(name: "example_form_favourite_drink"))
    end

    it "passes the collection, reformatted with 'label', 'value' and 'checked' keys to the radio group component" do
      builder.cads_collection_radio_buttons(:favourite_drink, collection, :reference, :name)

      expect(component_double).to have_received(:with_inputs).with([
        { name: "example_form[favourite_drink]", label: "Tea", value: "0001", checked: false },
        { name: "example_form[favourite_drink]", label: "Coffee", value: "0002", checked: true },
        { name: "example_form[favourite_drink]", label: "Water", value: "9999", checked: false }
      ])
    end
  end

  describe "#cads_collection_select" do
    let(:component) { CitizensAdviceComponents::Select }
    let(:component_double) { instance_double(component, render_in: nil) }

    let(:drink) { Struct.new(:reference, :colour, :name) }
    let(:collection) do
      [
        drink.new("0001", "Light Brown", "Tea"),
        drink.new("0002", "Dark Brown", "Coffee"),
        drink.new("9999", "Clear", "Water")
      ]
    end

    it "passes the attribute name to the select component" do
      builder.cads_collection_select(:favourite_drink, collection, :reference, :name)

      expect(component).to have_received(:new).with(hash_including(name: "example_form_favourite_drink"))
    end

    it "passes the collection, reformatted with 'select_options' and 'value' keys to the select component" do
      builder.cads_collection_select(:favourite_drink, collection, :reference, :name)

      expect(component).to have_received(:new).with(
        hash_including(
          select_options: [
            %w[Tea 0001], %w[Coffee 0002], %w[Water 9999]
          ],
          value: "0002"
        )
      )
    end

    it "passes the optional legend to the select component" do
      builder.cads_collection_select(:favourite_drink, collection, :reference, :name, legend: "Total legend!")

      expect(component).to have_received(:new).with(hash_including(legend: "Total legend!"))
    end
  end
end
