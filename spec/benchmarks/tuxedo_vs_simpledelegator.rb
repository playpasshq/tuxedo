require 'benchmark/ips'
require 'tuxedo'
require 'delegate'

class Country
  attr_accessor :name, :id
end

class CountryDecorator < SimpleDelegator
  def fancy_name
    "fancy" + __getobj__.name
  end
end

class CountryPresenter
  include Tuxedo

  def fancy_name
    "fancy" + object.name
  end
end

class CharlatanProxy
  include Charlatan.new(:country)
  def fancy_name
    "fancy" + country.name
  end
end

country = Country.new
country.name = "Tuxedo"
country.id = 111

tuxedo = CountryPresenter.new(country, nil)
simple_delegator = CountryDecorator.new(country)
charlatan = CharlatanProxy.new(country)

puts 'Calling a method that is defined on the presenter:'
Benchmark.ips do |x|
  x.report("simpleDelegator") { simple_delegator.fancy_name }
  x.report("tuxedo") { tuxedo.fancy_name }
  x.report("charlatan") { charlatan.fancy_name }

  # Compare the iterations per second of the various reports!
  x.compare!
end

puts 'Calling a method that needs to be delegated:'
Benchmark.ips do |x|
  x.report("simpleDelegator") { simple_delegator.id }
  x.report("tuxedo") { tuxedo.id }
  x.report("charlatan") { charlatan.id }

  # Compare the iterations per second of the various reports!
  x.compare!
end
