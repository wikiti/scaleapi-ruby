# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: scaleapi-ruby 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "scaleapi-ruby"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Daniel Herzog"]
  s.date = "2016-09-21"
  s.description = "A ruby gem wrapper for the Scale API, containing all the endpoints available."
  s.email = "info@danielherzog.es"
  s.extra_rdoc_files = [
    "LICENSE.md",
    "README.md"
  ]
  s.files = [
    ".document",
    "CONTRIBUTING.md",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.md",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/scale.rb",
    "lib/scale/api.rb",
    "lib/scale/callbacks/base.rb",
    "lib/scale/callbacks/task.rb",
    "lib/scale/endpoints/endpoint.rb",
    "lib/scale/endpoints/tasks/cancel_task.rb",
    "lib/scale/endpoints/tasks/create_annotation_task.rb",
    "lib/scale/endpoints/tasks/create_categorization_task.rb",
    "lib/scale/endpoints/tasks/create_comparison_task.rb",
    "lib/scale/endpoints/tasks/create_phonecall_task.rb",
    "lib/scale/endpoints/tasks/create_transcription_task.rb",
    "lib/scale/endpoints/tasks/list_tasks.rb",
    "lib/scale/endpoints/tasks/retrieve_task.rb",
    "lib/scale/endpoints/tasks/task_endpoint.rb",
    "lib/scale/generic_error.rb",
    "lib/scale/http_error.rb",
    "lib/scale/resources/base.rb",
    "lib/scale/resources/task.rb",
    "test/callbacks/test_task_callback.rb",
    "test/fixtures/callback.json",
    "test/fixtures/vcr_cassettes/tasks.yml",
    "test/helper.rb",
    "test/tasks/test_cancel_task.rb",
    "test/tasks/test_create_annotation_task.rb",
    "test/tasks/test_create_categorization_task.rb",
    "test/tasks/test_create_comparison_task.rb",
    "test/tasks/test_create_phonecall_task.rb",
    "test/tasks/test_create_transcription_task.rb",
    "test/tasks/test_list_tasks.rb",
    "test/tasks/test_retrieve_task.rb",
    "test/test_api.rb"
  ]
  s.homepage = "http://github.com/wikiti/scaleapi-ruby"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "A ruby gem wrapper for the Scale API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<juwelier>, ["~> 2.1.0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<pry-nav>, [">= 0"])
    else
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<juwelier>, ["~> 2.1.0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<pry-nav>, [">= 0"])
    end
  else
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<juwelier>, ["~> 2.1.0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<pry-nav>, [">= 0"])
  end
end

