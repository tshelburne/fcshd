require "./lib/fcshd/version"

name, version = "fcshd", FCSHD::VERSION

gem = "#{name}-#{version}.gem"
gemspec = "#{name}.gemspec"
sources = FileList["{bin,lib}/**/*"]

task :default => [:uninstall, :install]

task :install => gem do
  sh "gem install #{gem}"
end

task :uninstall do
  sh "gem uninstall -ax #{name}"
end

file gem => FileList[gemspec, sources] do
  sh "gem build #{gemspec}"
end

task :push => gem do
  sh "gem push #{gem}"
  sh "gem install #{name}"
end

require "rake/clean"

CLEAN << "*.gem"
