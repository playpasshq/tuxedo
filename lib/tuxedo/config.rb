require 'active_support/configurable'

# Tuxedo main module
module Tuxedo
  # Configures global settings for Tuxedo
  #
  # @example
  #
  #   Tuxedo.configure do |config|
  #     config.suffix = 'Presenter'
  #   end
  #
  # @return [Tuxedo::Configuration]
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
    config_accessor(:suffix) { 'Presenter' }
  end
end
