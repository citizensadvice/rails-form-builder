# frozen_string_literal: true

require "rails_helper"

RSpec.describe "example forms" do
  # rubocop:disable RSpec/ExampleLength
  it "renders the people form" do
    visit example_forms_path

    # Submit empty form
    click_button "Save"

    # "first_name" is required
    expect(page).to have_css("p#person_first_name-error")

    # Fill in form fields
    fill_in "First name", with: "Francis"
    fill_in "Last name", with: "Example"
    fill_in "Address", with: "42 Foundry Mews\r\nYaughton\r\nShropshire"

    # Submit form
    click_button "Save"

    expect(page).to have_field("person[first_name]", with: "Francis")
    expect(page).to have_field("person[last_name]", with: "Example")
    expect(page).to have_field("person[address]", with: "42 Foundry Mews\r\nYaughton\r\nShropshire")

    expect(page).to have_button("Save")
  end
  # rubocop:enable RSpec/ExampleLength
end
