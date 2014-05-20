# Gitlab - The Engine

This is a fork of the [Gitlab Community Edition
project](https://github.com/gitlabhq/gitlabhq).  I am not affiliated in any
way with the official Gitlab project or with Gitlab B.V.

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
application and database.  Deploying with the Gitlab engine is the same as with Gitlab itself, 

See my gitlab-engine-examples project for some simple apps that
build functionality on top of Gitlab.

## Maintenance Process

The master branch of this project pulls from the master branch of Gitlab's
Github [repository](https://github.com/gitlabhq/gitlabhq.git).  This README is
the only file that diverges from upstream.  Commits from upstream are merged
whenever Gitlab releases a new stable version, using the merge base between the
upstream master and the latest x-x-stable branch.

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
security and bug fixes from the upstream `x-x-stable` branches.

## Using Gitlab as an Engine

To add the Gitlab engine to your Rails app, update your Gemfile with something like this:

    gem 'gitlab', '6.9.0', :github => 'mr-vinn/gitlab', :branch => '6-9-stable-engine'

You can use one of the `x-x-stable-engine` branches, or the `engine` branch
directly.  The `x-y-z` tags are only available on the stable engine branches,
so if you want to configure a specific version of gitlab in your app then you
should use the appropriate `x-x-stable-engine` branch.

## NOTE: The rest of this document is the official Gitlab Community Edition README

## GitLab: self hosted Git management software

![logo](https://gitlab.com/gitlab-org/gitlab-ce/raw/master/public/gitlab_logo.png)

![animated-screenshots](https://gist.github.com/fnkr/2f9badd56bfe0ed04ee7/raw/4f48806fbae97f556c2f78d8c2d299c04500cb0d/compiled.gif)

### Gitlab is open source software to collaborate on code

* Manage git repositories with fine grained access controls that keep your code secure
* Perform code reviews and enhance collaboration with merge requests
* Each project can also have an issue tracker and a wiki
* Used by more than 100,000 organizations, GitLab is the most popular solution to manage git repositories on-premises
* Completely free and open source (MIT Expat license)
* Powered by Ruby on Rails

### Canonical source

* The source of GitLab Community Edition is [hosted on GitLab.com](https://gitlab.com/gitlab-org/gitlab-ce/) and there are mirrors to make [contributing](CONTRIBUTING.md) as easy as possible.

### Code status

* [![build status](https://ci.gitlab.org/projects/1/status.png?ref=master)](https://ci.gitlab.org/projects/1?ref=master) on ci.gitlab.org (master branch)

* [![Code Climate](https://codeclimate.com/github/gitlabhq/gitlabhq.png)](https://codeclimate.com/github/gitlabhq/gitlabhq)

* [![Coverage Status](https://coveralls.io/repos/gitlabhq/gitlabhq/badge.png?branch=master)](https://coveralls.io/r/gitlabhq/gitlabhq)

* [![PullReview stats](https://www.pullreview.com/gitlab/gitlab-org/gitlab-ce/badges/master.svg?)](https://www.pullreview.com/gitlab.gitlab.com/gitlab-org/gitlab-ce/reviews/master)

### Resources

* [GitLab.com](https://www.gitlab.com/) includes information about [subscriptions](https://www.gitlab.com/subscription/), [consultancy](https://www.gitlab.com/consultancy/), the [community](https://www.gitlab.com/community/) and the [hosted GitLab Cloud](https://www.gitlab.com/cloud/).

* [GitLab Enterprise Edition](https://www.gitlab.com/gitlab-ee/) offers additional features aimed at larger organizations.

* [GitLab CI](https://www.gitlab.com/gitlab-ci/) is a continuous integration (CI) server that is easy to integrate with GitLab.

* Unofficial third-party [iPhone app](http://gitlabcontrol.com/), [Android app](https://play.google.com/store/apps/details?id=com.bd.gitlab&hl=en) and [command line client](https://github.com/drewblessing/gitlab-cli) and [Ruby API wrapper](https://github.com/NARKOZ/gitlab) for GitLab.

### Requirements

* Ubuntu/Debian/CentOS/RHEL**
* ruby 1.9.3+
* git 1.7.10+
* redis 2.0+
* MySQL or PostgreSQL

** More details are in the [requirements doc](doc/install/requirements.md)

### Installation

#### Official installation methods

* [GitLab packages](https://www.gitlab.com/downloads/) **recommended** These packages contain GitLab and all its depencies (Ruby, PostgreSQL, Redis, Nginx, Unicorn, etc.). They are made with [omnibus-gitlab](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md) that also contains the installation instructions.

* [GitLab Chef Cookbook](https://gitlab.com/gitlab-org/cookbook-gitlab/blob/master/README.md) This cookbook can be used both for development installations and production installations. If you want to [contribute](CONTRIBUTE.md) to GitLab we suggest you follow the [development installation on a virtual machine with Vagrant](https://gitlab.com/gitlab-org/cookbook-gitlab/blob/master/doc/development.md) instructions to install all testing dependencies.

* [Manual installation guide](doc/install/installation.md) This guide to set up a production server on Ubuntu offers detailed and complete step-by-step instructions.

#### Third party one-click installers

* [Digital Ocean 1-Click Application Install](https://www.digitalocean.com/blog_posts/host-your-git-repositories-in-55-seconds-with-gitlab) Have a new server up in 55 seconds. Digital Ocean uses SSD disks which is great for an IO intensive app such as GitLab. We recommend selecting a droplet with [1GB of memory](https://github.com/gitlabhq/gitlabhq/blob/master/doc/install/requirements.md).

* [BitNami one-click installers](http://bitnami.com/stack/gitlab) This package contains both GitLab and GitLab CI. It is available as installer, virtual machine or for cloud hosting providers (Amazon Web Services/Azure/etc.).

* [Cloud 66 deployment and management](http://blog.cloud66.com/installing-gitlab-ubuntu/) Use Cloud 66 to deploy GitLab to your own server or any cloud (eg. DigitalOcean, AWS, Rackspace, GCE) and then manage it with database backups, scaling and more.

#### Unofficial installation methods

* [GitLab recipes](https://gitlab.com/gitlab-org/gitlab-recipes/) repository with unofficial guides for using GitLab with different software (operating systems, webservers, etc.) than the official version.

* [Installation guides](https://github.com/gitlabhq/gitlab-public-wiki/wiki/Unofficial-Installation-Guides) public wiki with unofficial guides to install GitLab on different operating systems.

### New versions and upgrading

Since 2011 GitLab is released on the 22nd of every month. Every new release includes an [upgrade guide](doc/update) and new features are detailed in the [Changelog](CHANGELOG).

It is recommended to follow a monthly upgrade schedule. Security releases come out when needed. For more information about the release process see the documentation for [monthly](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/release/monthly.md) and [security](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/release/security.md) releases.

* Features that will be in the next releases are listed on the [feature request forum](http://feedback.gitlab.com/forums/176466-general) with the status [started](http://feedback.gitlab.com/forums/176466-general/status/796456) and [completed](http://feedback.gitlab.com/forums/176466-general/status/796457).

### Run in production mode

The Installation guide contains instructions on how to download an init script and run it automatically on boot. You can also start the init script manually:

    sudo service gitlab start

or by directly calling the script

     sudo /etc/init.d/gitlab start

Please login with root / 5iveL!fe

### Run in development mode

Consider setting up the development environment with [the cookbook](https://gitlab.com/gitlab-org/cookbook-gitlab/blob/master/README.md#installation).

Copy the example development unicorn configuration file

    cp config/unicorn.rb.example.development config/unicorn.rb

Start it with [Foreman](https://github.com/ddollar/foreman)

    bundle exec foreman start -p 3000

or start each component separately

    bundle exec rails s
    script/background_jobs start

And surf to [localhost:3000](http://localhost:3000/) and login with root / 5iveL!fe

### Run the tests

* Run all tests

        bundle exec rake test

* [RSpec](http://rspec.info/) unit and functional tests

        All RSpec tests: bundle exec rake spec

        Single RSpec file: bundle exec rspec spec/controllers/commit_controller_spec.rb

* [Spinach](https://github.com/codegram/spinach) integration tests

        All Spinach tests: bundle exec rake spinach

        Single Spinach test: bundle exec spinach features/project/issues/milestones.feature


### Documentation

All documentation can be found on [doc.gitlab.com/ce/](http://doc.gitlab.com/ce/).

### Getting help

Please see [Getting help for GitLab](https://www.gitlab.com/getting-help/) on our website for the many options to get help.
