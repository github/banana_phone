require 'rake/testtask'
Rake::TestTask.new('test') do |t|
  t.test_files = FileList['test/*_test.rb']
  t.ruby_opts += ['-rubygems -Itest'] if defined? Gem
end

task :default => :test

task :console do
  exec('irb -Ilib -rbertrpc')
end