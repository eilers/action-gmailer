# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "action-gmailer"
  gem.homepage = "http://github.com/popgiro/action-gmailer"
  gem.license = "MIT"
  gem.summary = %Q{ActionGmailer, oauth/gmail delivery method}
  gem.description = %Q{ActionGmailer, oauth/gmail delivery method}
  gem.email = "tilljoel@gmail.com"
  gem.authors = ["Joel Larsson"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

