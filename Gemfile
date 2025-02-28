# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in citizens_advice_form_builder.gemspec
gemspec

gem "citizens_advice_components",
    github: "citizensadvice/design-system",
    tag: "v6.4.1",
    glob: "engine/*.gemspec"

rails_version = ENV.fetch("RAILS_VERSION", "~> 8.0.0").to_s

gem "actionpack", rails_version
gem "actionview", rails_version
gem "activerecord", rails_version
gem "activesupport", rails_version

group :development, :test do
  gem "citizens-advice-style",
      github: "citizensadvice/citizens-advice-style-ruby",
      tag: "v10.0.1"

  gem "capybara"
  gem "launchy"
  gem "pry"
  gem "rake", "~> 13.0"
  gem "rspec", "~> 3.0"
  gem "rspec-rails"
  gem "rubocop-rake"
end
