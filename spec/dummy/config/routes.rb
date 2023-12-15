# frozen_string_literal: true

Rails.application.routes.draw do
  resources :example_forms, only: %i[index create]
end
