# frozen_string_literal: true

class ExampleForm
  include ActiveModel::Model

  attr_accessor :favourite_drink
end

RSpec.describe CitizensAdviceFormBuilder::Elements::Collections::RadioButtons do
  include_context "with view component"

  let(:component) { CitizensAdviceComponents::RadioGroup }
  let(:component_double) { instance_double(component, with_inputs: nil, render_in: nil) }
  let(:model) { ExampleForm.new(favourite_drink: "0002") }

  describe "#render" do
    let(:drink) { Struct.new(:reference, :colour, :name) }

    let(:collection) do
      [
        drink.new("0001", "Light Brown", "Tea"),
        drink.new("0002", "Dark Brown", "Coffee")
      ]
    end

    it "passes the attribute name to the radio group component" do
      builder.cads_collection_radio_buttons(:favourite_drink, collection: collection, text_method: :name, value_method: :reference)

      expect(component).to have_received(:new).with(hash_including(name: "example_form_favourite_drink"))
    end

    it "passes the collection, reformatted with 'label', 'value' and 'checked' keys to the radio group component" do
      builder.cads_collection_radio_buttons(:favourite_drink, collection: collection, text_method: :name, value_method: :reference)

      expect(component_double).to have_received(:with_inputs).with([
        { name: "example_form[favourite_drink]", label: "Tea", value: "0001", checked: false },
        { name: "example_form[favourite_drink]", label: "Coffee", value: "0002", checked: true }
      ])
    end

    it "sets 'optional' to 'true' by default" do
      builder.cads_collection_radio_buttons(:favourite_drink, collection: collection, text_method: :name, value_method: :reference)

      expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: true)))
    end

    context "with 'required' parameter" do
      # rubocop:disable RSpec/ExampleLength
      it "sets 'optional' to 'false' when true" do
        builder.cads_collection_radio_buttons(
          :favourite_drink,
          collection: collection,
          text_method: :name,
          value_method: :reference,
          required: true
        )

        expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: false)))
      end

      it "sets 'optional' to 'true' when false" do
        builder.cads_collection_radio_buttons(
          :favourite_drink,
          collection: collection,
          text_method: :name,
          value_method: :reference,
          required: false
        )

        expect(component).to have_received(:new).with(hash_including(options: hash_including(optional: true)))
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "with 'hint' parameter" do
      # rubocop:disable RSpec/ExampleLength
      it "passes hint to the text input component" do
        builder.cads_collection_radio_buttons(
          :favourite_drink,
          collection: collection,
          text_method: :name,
          value_method: :reference,
          hint: "Example hint"
        )

        expect(component).to have_received(:new).with(hash_including(options: hash_including(hint: "Example hint")))
      end
      # rubocop:enable RSpec/ExampleLength
    end

    context "when there is a validation error" do
      it "sets 'error_message'" do
        model.errors.add(:favourite_drink, :example, message: "example error")

        builder.cads_collection_radio_buttons(:favourite_drink, collection: collection, text_method: :name, value_method: :reference)

        expect(component).to have_received(:new).with(hash_including(options: hash_including(error_message: "example error")))
      end
    end
  end
end
