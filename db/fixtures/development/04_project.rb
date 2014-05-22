require 'ffaker'

Gitlab::Seeder.quiet do
  project_urls = [
    'https://github.com/documentcloud/underscore.git',
    'https://github.com/diaspora/diaspora.git',
    'https://github.com/diaspora/diaspora-project-site.git',
    'https://github.com/diaspora/diaspora-client.git',
    'https://github.com/brightbox/brightbox-cli.git',
    'https://github.com/brightbox/puppet.git',
    'https://github.com/gitlabhq/gitlabhq.git',
    'https://github.com/gitlabhq/gitlab-ci.git',
    'https://github.com/gitlabhq/gitlab-recipes.git',
    'https://github.com/gitlabhq/gitlab-shell.git',
    'https://github.com/gitlabhq/grack.git',
    'https://github.com/gitlabhq/testme.git',
    'https://github.com/twitter/flight.git',
    'https://github.com/twitter/typeahead.js.git',
    'https://github.com/h5bp/html5-boilerplate.git',
    'https://github.com/h5bp/mobile-boilerplate.git',
  ]

  project_urls.each_with_index do |url, i|
    group_path, project_path = url.split('/')[-2..-1]

    group = Gitlab::Group.find_by(path: group_path)

    unless group
      group = Gitlab::Group.new(
        name: group_path.titleize,
        path: group_path
      )
      group.description = Faker::Lorem.sentence
      group.save

      group.add_owner(Gitlab::User.first)
    end

    project_path.gsub!(".git", "")

    params = {
      import_url: url,
      namespace_id: group.id,
      name: project_path.titleize,
      description: Faker::Lorem.sentence,
      visibility_level: Gitlab::VisibilityLevel.values.sample
    }

    project = Gitlab::Projects::CreateService.new(Gitlab::User.first, params).execute

    if project.valid?
      print '.'
    else
      puts project.errors.full_messages
      print 'F'
    end
  end
end
