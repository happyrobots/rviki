$:.unshift File.expand_path("../lib", __FILE__)
require File.dirname(__FILE__) + "/lib/rviki/version"

Gem::Specification.new do |s|
  s.name        = "rviki"
  s.version     = RViki::VERSION::STRING
  s.author      = ["Nia M"]
  s.email       = ["nia@viki.com"]
  s.homepage    = ""
  s.license     = ''
  s.description = "A short description"
  s.summary     = "A longer summary"
  s.executables = %w(rviki1 rviki2 rviki3)
  s.files       = %x{ git ls-files }.split("\n").select { |d| d =~ %r{^(License|README|bin/|data/|ext/|lib/|spec/|test/)} }

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md", "CHANGELOG"]

  s.add_dependency('httparty')

  s.add_development_dependency("rspec", ">= 2.5.1")
  s.add_development_dependency("ZenTest", ">= 4.5.0")
  s.add_development_dependency("rake", ">= 0.8.7")
  s.add_development_dependency("bundler", ">= 1.0.12")

  s.require_path = 'lib'
  s.files = %w(README.md Rakefile) + Dir.glob("lib/**/*")
end
