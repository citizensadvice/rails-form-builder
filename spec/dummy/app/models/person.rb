# frozen_string_literal: true

class Person
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :address

  validates :first_name, presence: true
end
