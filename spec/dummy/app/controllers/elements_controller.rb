# frozen_string_literal: true

class ElementsController < ApplicationController
  def index
    @person = Person.new

    render params[:element]
  end
end
