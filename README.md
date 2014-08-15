# Gitlab: The Engine

This is a fork of the [Gitlab Community Edition
project](https://github.com/gitlabhq/gitlabhq).  I am not affiliated in any
way with the official Gitlab project or with [Gitlab
B.V.](https://about.gitlab.com/about/)

This fork aims to repackage the Gitlab Community Edition application into a
[Rails Mountable Engine](http://guides.rubyonrails.org/engines.html) so that
you can easily embed a self-hosted Gitlab instance into a custom Rails
application.  You can already interact with a Gitlab instance from your own
Rails app via the [Gitlab API](doc/api/README.md), and with [web
hooks](doc/web_hooks/web_hooks.md) and [system
hooks](doc/system_hooks/system_hooks.md).  The API lets you view and manipulate
Gitlab's objects, and your application can use web and system hooks to respond
to Gitlab's events.  You can interact with Gitlab in the same ways when you use
it as a mountable engine, but doing so means that you only deal with a single
application and database.  You can also customize Gitlab more deeply by
overriding default behavior, or by modifying Gitlab's views (without having to
maintain a fork of its source code).

See my gitlab-engine-examples project for some simple apps that
build functionality on top of Gitlab.

## Engine Maintenance Process

The master branch of this project pulls from the master branch of Gitlab's
Github [repository](https://github.com/gitlabhq/gitlabhq.git).  This README is
the only file that diverges from upstream.  Commits from upstream are merged
whenever Gitlab releases a new stable version, using the merge base between the
upstream master and the latest upstream x-x-stable branch.

The `namespace` branch is functionally identical to the official Gitlab app,
but Ruby classes and view files are moved into a namespaced directory tree.
After merging a new upstream release into our master branch, the master branch
is merged into `namespace`.  After resolving merge conflicts, additional
commits are made on this branch as necessary to make Rspec and Spinach tests
pass.  When all tests pass, a new branch is checked out named
`x-x-stable-namespace`.  Each stable branch receives security and bug fixes
from the corresponding upstream `x-x-stable` branch.

The `engine` branch is based on the `namespace` branch, but is configured as a
mountable engine instead of a standalone Rails application.  This branch
receives updates from `namespace` after new upstream releases are merged.  When
`namespace`->`engine` merge conflicts are resolved, the engine is tested with a
dummy application created for the `engine` branch.  When all tests pass, a new
branch is checked out named `x-x-stable-engine`.  These stable branches receive
security and bug fixes from the upstream `x-x-stable` branches via the
`x-x-stable-namespace` branches.

## Using Gitlab as an Engine

* To add the Gitlab engine to your Rails app, update your Gemfile with something
  like this:

        gem 'gitlab', '6.9.0', :github => 'mr-vinn/gitlab', :branch => '6-9-stable-engine'

  You can use one of the `x-x-stable-engine` branches, or the `engine` branch
  directly.  The `x-y-z` tags are only available on the stable engine branches,
  so if you want to configure a specific version of upstream Gitlab in your app
  then you should use the appropriate `x-x-stable-engine` branch.

* Run `bundle install` to install the gitlab-engine gem and its dependencies.

* Run `rails g gitlab:install [postgresql|mysql]` to add default configuration
  files, a database migration, and scripts to your application.  A database
  configuration file is also copied for the database type you specify on the
  command line.

  By default, the install generator runs in interactive mode and prompts you
  for things like email addresses and hostnames; it uses your answers to
  customize your Gitlab configuration files.

* Review the YML files that the generator copied to `config/`, and edit them to
  suit your needs.

## NOTE: The rest of this document is the official Gitlab Community Edition README

# GitLab

## Open source software to collaborate on code

![logo](https://gitlab.com/gitlab-org/gitlab-ce/raw/master/public/gitlab_logo.png)

![animated-screenshots](https://gist.github.com/fnkr/2f9badd56bfe0ed04ee7/raw/4f48806fbae97f556c2f78d8c2d299c04500cb0d/compiled.gif)

- Manage Git repositories with fine grained access controls that keep your code secure
- Perform code reviews and enhance collaboration with merge requests
- Each project can also have an issue tracker and a wiki
- Used by more than 100,000 organizations, GitLab is the most popular solution to manage Git repositories on-premises
- Completely free and open source (MIT Expat license)
- Powered by Ruby on Rails

## Canonical source

- The source of GitLab Community Edition is [hosted on GitLab.com](https://gitlab.com/gitlab-org/gitlab-ce/) and there are mirrors to make [contributing](CONTRIBUTING.md) as easy as possible.

## Code status

- [![build status](https://ci.gitlab.org/projects/1/status.png?ref=master)](https://ci.gitlab.org/projects/1?ref=master) on ci.gitlab.org (master branch)

- [![Code Climate](https://codeclimate.com/github/gitlabhq/gitlabhq.png)](https://codeclimate.com/github/gitlabhq/gitlabhq)

- [![Coverage Status](https://coveralls.io/repos/gitlabhq/gitlabhq/badge.png?branch=master)](https://coveralls.io/r/gitlabhq/gitlabhq)

- [![PullReview stats](https://www.pullreview.com/gitlab/gitlab-org/gitlab-ce/badges/master.svg?)](https://www.pullreview.com/gitlab.gitlab.com/gitlab-org/gitlab-ce/reviews/master)

## Website

On [www.gitlab.com](https://www.gitlab.com/) you can find more information about:

- [Subscriptions](https://www.gitlab.com/subscription/)
- [Consultancy](https://www.gitlab.com/consultancy/)
- [Community](https://www.gitlab.com/community/)
- [Hosted GitLab.com](https://www.gitlab.com/gitlab-com/) use GitLab as a free service
- [GitLab Enterprise Edition](https://www.gitlab.com/gitlab-ee/) with additional features aimed at larger organizations.
- [GitLab CI](https://www.gitlab.com/gitlab-ci/) a continuous integration (CI) server that is easy to integrate with GitLab.

## Third-party applications

Access GitLab from multiple platforms with applications below.
These applications are maintained by contributors, GitLab B.V. does not offer support for them.

- [iPhone app](http://gitlabcontrol.com/)
- [Android app](https://play.google.com/store/apps/details?id=com.bd.gitlab&hl=en)
- [Chrome app](https://chrome.google.com/webstore/detail/chrome-gitlab-notifier/eageapgbnjicdjjihgclpclilenjbobi)
- [Command line client](https://github.com/drewblessing/gitlab-cli)
- [Ruby API wrapper](https://github.com/NARKOZ/gitlab)

## Requirements

- Ubuntu/Debian/CentOS/RHEL**
- ruby 2.0+
- git 1.7.10+
- redis 2.0+
- MySQL or PostgreSQL

** More details are in the [requirements doc](doc/install/requirements.md).

## Installation

Please see [the installation page on the GitLab website](https://www.gitlab.com/installation/).

### New versions

Since 2011 a minor or major version of GitLab is released on the 22nd of every month. Patch and security releases come out when needed.  New features are detailed on the [blog](https://www.gitlab.com/blog/) and in the [changelog](CHANGELOG). For more information about the release process see the release [documentation](https://gitlab.com/gitlab-org/gitlab-ce/tree/master/doc/release). Features that will likely be in the next releases can be found on the [feature request forum](http://feedback.gitlab.com/forums/176466-general) with the status [started](http://feedback.gitlab.com/forums/176466-general/status/796456) and [completed](http://feedback.gitlab.com/forums/176466-general/status/796457).

### Upgrading

For updating the the Omnibus installation please see the [update documentation](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/update.md). For manual installations there is an [upgrader script](doc/update/upgrader.md) and there are [upgrade guides](doc/update).

## Run in production mode

The Installation guide contains instructions on how to download an init script and run it automatically on boot. You can also start the init script manually:

    sudo service gitlab start

or by directly calling the script:

     sudo /etc/init.d/gitlab start

Please login with `root` / `5iveL!fe`.

## Install a development environment

We recommend setting up your development environment with [the cookbook](https://gitlab.com/gitlab-org/cookbook-gitlab/blob/master/README.md#installation). If you do not use the cookbook you might need to copy the example development unicorn configuration file

    cp config/unicorn.rb.example.development config/unicorn.rb

## Run in development mode

Start it with [Foreman](https://github.com/ddollar/foreman)

    bundle exec foreman start -p 3000

or start each component separately:

    bundle exec rails s
    bin/background_jobs start

And surf to [localhost:3000](http://localhost:3000/) and login with `root` / `5iveL!fe`.

## Run the tests

-   Run all tests:

        bundle exec rake test

-   [RSpec](http://rspec.info/) unit and functional tests.

    All RSpec tests: `bundle exec rake spec`

    Single RSpec file: `bundle exec rspec spec/controllers/commit_controller_spec.rb`

-   [Spinach](https://github.com/codegram/spinach) integration tests.

    All Spinach tests: `bundle exec rake spinach`

    Single Spinach test: `bundle exec spinach features/project/issues/milestones.feature`

## Documentation

All documentation can be found on [doc.gitlab.com/ce/](http://doc.gitlab.com/ce/).

## Getting help

Please see [Getting help for GitLab](https://www.gitlab.com/getting-help/) on our website for the many options to get help.

## Is it any good?

[Yes](https://news.ycombinator.com/item?id=3067434)

## Is it awesome?

Thanks for [asking this question](https://twitter.com/supersloth/status/489462789384056832) Joshua.
[These people](https://twitter.com/gitlabhq/favorites) seem to like it.
