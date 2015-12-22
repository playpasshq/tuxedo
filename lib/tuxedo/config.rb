require 'active_support/configurable'

module Tuxedo
  # Configures global settings for Tuxedo
  #
  #   Tuxedo.configure do |config|
  #     config.namespace = 'Presenter'
  #   end
  #
  # @param [block] block to yield
  #
  def self.configure
    yield @config ||= Tuxedo::Configuration.new
  end

  # Returns the current config
  #
  # @return [Tuxedo::Configuration]
  #
  def self.config
    @config || Tuxedo::Configuration.new
  end

  # @api private
  class Configuration
    include ActiveSupport::Configurable
    config_accessor(:namespace) { 'Presenter' }
  end
end
