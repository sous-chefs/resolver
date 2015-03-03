require 'bundler/setup'
require 'rubocop/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'
require 'kitchen'

namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = { fail_tags: ['any'] }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

desc 'Run ChefSpec unit tests'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = '--color --format progress'
end

desc 'Run Test Kitchen integration tests'
task :integration do
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end

# The default rake task should just run it all
task default: %w(style integration)
# task default: %w(style)

task travis: %w(style)

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
