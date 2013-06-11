# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "kojn"
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeffrey Wilcke", "Maran Hidskes"]
  s.date = "2013-06-11"
  s.description = "Ruby gem for communicating with the kojn.nl API. Allows you to create and managed invoices."
  s.email = ["maran.hidskes@gmail.com", "jeff.wilcke@gmail.com"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "kojn.gemspec",
    "lib/app.rb",
    "lib/kojn.rb",
    "lib/kojn/collection.rb",
    "lib/kojn/crypto.rb",
    "lib/kojn/invoice.rb",
    "lib/kojn/ipn.rb",
    "lib/kojn/model.rb",
    "lib/kojn/net.rb",
    "lib/kojn/net_old.rb",
    "lib/kojn/transaction.rb",
    "lib/kojn/version.rb",
    "spec/.rspec",
    "spec/collection_spec.rb",
    "spec/inflector_spec.rb",
    "spec/spec_helper.rb",
    "spec/transaction_spec.rb"
  ]
  s.homepage = "https://kojn.nl"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Ruby gem for communicating with the kojn.nl API."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0"])
      s.add_runtime_dependency(%q<curb>, ["> 0.8.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3.5"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0.0"])
    else
      s.add_dependency(%q<activemodel>, [">= 3.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0"])
      s.add_dependency(%q<curb>, ["> 0.8.1"])
      s.add_dependency(%q<bundler>, ["~> 1.3.5"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 4.0.0"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 3.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0"])
    s.add_dependency(%q<curb>, ["> 0.8.1"])
    s.add_dependency(%q<bundler>, ["~> 1.3.5"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 4.0.0"])
  end
end

