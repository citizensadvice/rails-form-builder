# frozen_string_literal: true

class ExampleFormsController < ApplicationController
  def index
    @person = Person.new
    @animals = animal_list
  end

  def create
    @person = Person.new(person_params)
    @animals = animal_list

    @person.valid?

    render :index
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :address, :favourite_animal)
  end

  def animal_list
    [
      Animal.new(id: 1, animal_type: "Cat"),
      Animal.new(id: 2, animal_type: "Dog")
    ]
  end
end
