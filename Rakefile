require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new(:test) do |t| 
    t.pattern = "test/**/*_test.rb"
    t.options = '-v'
end

task :default do |t|
    Rake::Task["test"].execute
end
