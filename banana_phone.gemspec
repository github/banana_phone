Gem::Specification.new do |s|
  s.name = %q{banana_phone}
  s.version = "0.1.3"
  s.authors = ["Tom Preston-Werner", "Brian Lopez"]
  s.email = %q{tom@mojombo.com seniorlopez@gmail.com}
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/github/banana_phone}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{BananaPhone is a RPC client for BananaPack}
  s.test_files = `git ls-files spec`.split("\n")

  s.add_runtime_dependency 'mochilo', ">= 0.6"

  # tests
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest_should'
  s.add_development_dependency 'shoulda'
end
