# Testing with different Rails versions

We test the form builder in CI in the last three supported versions of Rails. In local development we default to Rails 7.1.

You can test against different Rails versions locally by setting a `RAILS_VERSION` environment variable. First to install the new version:

```sh
RAILS_VERSION="~> 6.1.0" bundle install
```

Then to run the specs:

```sh
RAILS_VERSION="~> 6.1.0" bundle exec rspec
```

This will modify your `Gemfile.lock` so when you are done run:

```sh
git checkout -- Gemfile.lock
```

Followed by a fresh install:

```sh
bundle install
```
