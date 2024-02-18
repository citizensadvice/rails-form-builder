# frozen_string_literal: true

RSpec.describe CitizensAdviceFormBuilder::Elements::Button do
  let(:controller) { ActionController::Base.new }
  let(:lookup_context) { ActionView::LookupContext.new(nil) }
  let(:template) { ActionView::Base.new(lookup_context, {}, controller) }
  let(:builder) { CitizensAdviceFormBuilder::FormBuilder.new(:example_form, nil, template, {}) }
  let(:component_double) { instance_double(component, with_content: nil, render_in: nil) }

  let(:component) { CitizensAdviceComponents::Button }

  before { allow(component).to receive(:new).and_return(component_double) }

  describe "#render" do
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
end
