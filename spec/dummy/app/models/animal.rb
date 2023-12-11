# frozen_string_literal: true

class Animal
  include ActiveModel::Model

  attr_accessor :id, :animal_type
end
