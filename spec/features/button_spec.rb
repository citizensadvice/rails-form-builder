# frozen_string_literal: true

require "rails_helper"

RSpec.describe "buttons" do
  before do
    visit element_path("buttons")
  end

  it "renders a default button" do
    expect(page).to have_css(".cads-button__primary", text: "Default")
  end

  it "renders a secondary button" do
    expect(page).to have_css(".cads-button__secondary", text: "Secondary")
  end

  it "renders a button with type button" do
    expect(page).to have_css(".cads-button__primary[type=button]", text: "Button")
  end
end
