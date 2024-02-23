# frozen_string_literal: true

require "active_record/attribute_assignment"

class Person
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveRecord::AttributeAssignment

  attr_accessor :first_name, :last_name, :address, :date_with_hint, :required_date, :favourite_drink, :pizza_toppings

  attribute :date_of_birth, :date
  attribute :pizza_toppings, array: true

  validates :first_name, presence: true
end
