module Gitlab
  class Spinach::Features::ProjectGraph < Spinach::FeatureSteps
    include SharedAuthentication
    include SharedProject

    Then 'page should have graphs' do
      page.should have_selector ".stat-graph"
    end

    When 'I visit project "Shop" graph page' do
      project = Project.find_by(name: "Shop")
      visit gitlab_routes.project_graph_path(project, "master")
    end
  end
end
