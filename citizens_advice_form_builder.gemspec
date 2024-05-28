# frozen_string_literal: true

require_relative "lib/citizens_advice_form_builder/version"

Gem::Specification.new do |spec|
  spec.name = "citizens_advice_form_builder"
  spec.version = CitizensAdviceFormBuilder::VERSION
  spec.authors = ["Robert Lee-Cann"]

  spec.summary = "Citizens Advice custom Rails form builder"
  spec.homepage = "https://github.com/citizensadvice/rails-form-builder"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.1")

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

  spec.add_dependency "actionpack", ">= 7.0"
  spec.add_dependency "actionview", ">= 7.0"
  spec.add_dependency "activemodel", ">= 7.0"
  spec.add_dependency "activerecord", ">= 7.0"
  spec.add_dependency "activesupport", ">= 7.0"

  spec.add_dependency "citizens_advice_components"
end
