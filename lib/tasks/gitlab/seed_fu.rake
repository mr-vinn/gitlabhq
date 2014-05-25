namespace :gitlab do
  desc "GITLAB | Load data into the database"

  task seed_fu: :environment do
    ENV["FIXTURE_PATH"] = Gitlab::Engine.root.join("db", "fixtures", Rails.env).to_s
    Rake::Task["db:seed_fu"].invoke
  end
end
