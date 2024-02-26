# frozen_string_literal: true

require "rails_helper"

RSpec.describe "collection check boxes" do
  before do
    visit element_path("collection_check_boxes")
  end

  it "renders a number of check boxes" do
    expect(page).to have_unchecked_field("person[pizza_toppings][]", type: "checkbox", with: "Anchovies")
    expect(page).to have_unchecked_field("person[pizza_toppings][]", type: "checkbox", with: "Cheese")
    expect(page).to have_unchecked_field("person[pizza_toppings][]", type: "checkbox", with: "Pepperoni")
    expect(page).to have_unchecked_field("person[pizza_toppings][]", type: "checkbox", with: "Olives")
  end

  # rubocop:disable RSpec/ExampleLength
  it "remembers the selected values" do
    check "Cheese"
    check "Pepperoni"
    click_button

    expect(page).to have_checked_field("person[pizza_toppings][]", type: "checkbox", with: "Cheese")
    expect(page).to have_checked_field("person[pizza_toppings][]", type: "checkbox", with: "Pepperoni")

    expect(page).to have_unchecked_field("person[pizza_toppings][]", type: "checkbox", with: "Anchovies")
    expect(page).to have_unchecked_field("person[pizza_toppings][]", type: "checkbox", with: "Olives")
  end
  # rubocop:enable RSpec/ExampleLength
end
