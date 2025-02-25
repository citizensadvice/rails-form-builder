# frozen_string_literal: true

require_relative "lib/citizens_advice_form_builder/version"

Gem::Specification.new do |spec|
  spec.name = "citizens_advice_form_builder"
  spec.version = CitizensAdviceFormBuilder::VERSION
  spec.authors = ["Robert Lee-Cann"]

  spec.summary = "Citizens Advice custom Rails form builder"
  spec.homepage = "https://github.com/citizensadvice/rails-form-builder"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.2")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  %w[actionpack actionview activemodel activerecord activesupport].each do |rails_lib|
    spec.add_runtime_dependency rails_lib, [">= 7.1.0", "< 9.0"]
  end

  spec.add_dependency "citizens_advice_components"
end
