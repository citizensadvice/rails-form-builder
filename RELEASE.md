# How to release a new version of the Citizens Advice Form Builder

NB: We're currently using tagged releases in GitHub. In future, we'll likely be
publishing the gem to RubyGems.

## Tools

I've used the 'gem-release' gem to simplify the process a little.
Enter `gem install gem-release` to install on your local machine.

## Release Process

- Use `gem bump -v patch` to bump the patch release number of the gem
- Update `CHANGELOG.md` with any changes going into this release
- Use `gem tag` to create a git tag for the new version
- Push the tag up to the git remote with `git push origin --tags`
- Open a PR and get it merged into main
- Go to [the GitHub releases page](https://github.com/citizensadvice/rails-form-builder/releases) and click "Draft a new release"
- Choose the new version tag from the "Choose a tag" drop down.
- Copy the CHANGELOG changes into the "Describe this release" box
- Click "Publish release" button

You can now bump the tag of the gem in use in your Rails app, to pick up the latest changes.

