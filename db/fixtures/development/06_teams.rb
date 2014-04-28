Gitlab::Seeder.quiet do
  Gitlab::Group.all.each do |group|
    Gitlab::User.all.sample(4).each do |user|
      if group.add_users([user.id], Gitlab::UsersGroup.group_access_roles.values.sample)
        print '.'
      else
        print 'F'
      end
    end
  end

  Gitlab::Project.all.each do |project|
    Gitlab::User.all.sample(4).each do |user|
      if project.team << [user, Gitlab::UsersProject.access_roles.values.sample]
        print '.'
      else
        print 'F'
      end
    end
  end
end
