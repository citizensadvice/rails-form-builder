# frozen_string_literal: true

require "rails_helper"

RSpec.describe "text areas" do
  before do
    visit element_path("text_areas")
  end

  it "renders a default text area" do
    within "#default_text_area" do
      expect(page).to have_css("textarea")
    end
  end

  it "renders a text area with a custom number of rows" do
    within "#custom_rows_text_area" do
      expect(page).to have_css("textarea[rows=12]")
    end
  end
end
