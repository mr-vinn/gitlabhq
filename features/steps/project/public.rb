module Gitlab
  class Spinach::Features::PublicProjects < Spinach::FeatureSteps
    include SharedAuthentication
    include SharedProject
    include SharedPaths

    Then 'I should see the list of public projects' do
      page.should have_content "Public Projects"
    end
  end
end
