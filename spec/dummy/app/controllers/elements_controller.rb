# frozen_string_literal: true

class ElementsController < ApplicationController
  def index
    render params[:element]
  end
end
