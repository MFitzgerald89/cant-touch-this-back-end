# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

namespace :db do

  def cleanup_schema

    filename = "db/schema.rb"

    schema = File.read(filename)
             .split("\n")
             .select { |l| not l.strip.starts_with? "#" }
             .slice(1..-1)
             .push("")
             .join("\n")

    File.open(filename, 'w') do |file|
      file.write(schema)
    end

  end

  task :migrate do
    cleanup_schema
  end

end