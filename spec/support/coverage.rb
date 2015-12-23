if ENV['TRAVIS'] || ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.add_filter '/spec/'

  if ENV['TRAVIS']
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter.start
  else
    SimpleCov.start
  end

  SimpleCov.command_name "rspec_#{Process.pid}"
end
