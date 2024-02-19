# frozen_string_literal: true

require "rails_helper"

RSpec.describe "date inputs" do
  before do
    visit element_path("date_inputs")
  end

  context "with the default date input" do
    it "renders the 'day' input field" do
      within "#default_date_input" do
        expect(page).to have_css("label[for=person_date_of_birth_3i]", text: "Day")
        expect(page).to have_field("person_date_of_birth_3i", name: "person[date_of_birth(3i)]")
      end
    end

    it "renders the 'month' input field" do
      within "#default_date_input" do
        expect(page).to have_css("label[for=person_date_of_birth_2i]", text: "Month")
        expect(page).to have_field("person_date_of_birth_2i", name: "person[date_of_birth(2i)]")
      end
    end

    it "renders the 'year' input field" do
      within "#default_date_input" do
        expect(page).to have_css("label[for=person_date_of_birth_1i]", text: "Year")
        expect(page).to have_field("person_date_of_birth_1i", name: "person[date_of_birth(1i)]")
      end
    end

    it "doesn't include a hint" do
      within "#default_date_input" do
        expect(page).not_to have_css("p.cads-form-field__hint")
      end
    end
  end

  it "renders a hint" do
    within "#date_input_with_hint" do
      expect(page).to have_css("p.cads-form-field__hint", text: "Hint text")
    end
  end

  # rubocop:disable RSpec/ExampleLength
  it "stores and retrieves the day, month and year values in a Rails-compatible way" do
    within "#default_date_input" do
      fill_in "person_date_of_birth_3i", with: 13
      fill_in "person_date_of_birth_2i", with: 12
      fill_in "person_date_of_birth_1i", with: 2005
    end

    click_button

    expect(page).to have_field("person_date_of_birth_3i", with: "13")
    expect(page).to have_field("person_date_of_birth_2i", with: "12")
    expect(page).to have_field("person_date_of_birth_1i", with: "2005")
  end
  # rubocop:enable RSpec/ExampleLength
end
