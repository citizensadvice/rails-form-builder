# frozen_string_literal: true

require "rails_helper"

RSpec.describe "text inputs" do
  before do
    visit element_path("text_inputs")
  end

  it "renders a default text input, with 'id' and 'name' set correctly" do
    within "#default_text_field" do
      input = page.first("input")

      expect(input["name"]).to eql "person[first_name]"
      expect(input["id"]).to eql "person_first_name-input"
    end
  end
end
