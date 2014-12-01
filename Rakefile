#!/usr/bin/env rake
require 'rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.rspec_opts = '--color'
  end
rescue LoadError
  warn 'It looks like the Chef DK is not configured. Download the Chef DK'\
       " via\nhttps://downloads.getchef.com/chef-dk. On Linux and Mac OS X"\
       " add to $PATH with:\n"\
       '    eval "$(chef shell-init bash)"'
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.fail_on_error = true
    task.options = %w(--display-cop-names)
  end
rescue LoadError
  warn '>>>>> Rubocop gem not loaded, omitting tasks'
end

begin
  require 'foodcritic/rake_task'
  require 'foodcritic'
  task default: [:foodcritic]
  FoodCritic::Rake::LintTask.new do |task|
    task.options = {
      fail_tags: ['any'],
      tags: ['~FC015']
    }
  end
rescue LoadError
  warn '>>>>> foodcritic gem not loaded, omitting tasks'
end

task default: 'test:quick'
namespace :test do
  desc 'Run all the quick tests.'
  task :quick do
    Rake::Task['rubocop'].invoke
    Rake::Task['foodcritic'].invoke
  end
end

desc 'Bootstrap with chef-solo'
task :bootstrap do
  sh 'rm -rf cookbooks && berks vendor cookbooks'
  sh 'sudo chef-solo --json-attributes bootstrap/run_list.json'\
     '  --config bootstrap/solo.rb'
end

unless ENV['CI']
  begin
    require 'kitchen/rake_tasks'
    Kitchen::RakeTasks.new

    desc 'Run _all_ the tests. Go get a coffee.'
    task :complete do
      Rake::Task['test:quick'].invoke
      Rake::Task['test:kitchen:all'].invoke
    end
  rescue LoadError
    puts '>>>>> Kitchen gem not loaded, omitting tasks'
  end
end
