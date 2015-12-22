require 'tuxedo/version'
require 'active_support/concern'
require 'active_support/inflector'
require 'active_support/core_ext/module/delegation'
require 'charlatan'

require 'tuxedo/config'
require 'tuxedo/railitie' if defined?(Rails::Railtie)
require 'tuxedo/action_view/helpers'

# Tuxedo main module
# To use Tuxedo include it in any Ruby Object
#
# @example
#
#   class BananaPresenter
#     include Tuxedo
#
#     def name
#       'hello'
#     end
#
#     def name_with_args(name, surname: '')
#       "hello #{name}, #{surname}"
#     end
#   end
#
module Tuxedo
  extend ActiveSupport::Concern

  included do
    include Charlatan.new(:object)

    # Initializes a new Tuxedo class using the to decorate object and the view context
    # @param [Object] object to decorate
    # @param [ActionView::Context] view_context
    #
    def initialize(object, view_context)
      super(object)
      @view_context = view_context
      self.class.setup_alias_method
    end
  end

  class_methods do
    # Alias method name for accessing the original object
    # Defaults to guessing the name from the class
    #
    # @param [Symbol] name alias
    #
    def object_alias(name)
      setup_alias_method(name || underscored_name)
    end

    # Guesses the name using the class name
    #
    # @return [String]
    #
    def underscored_name
      name.demodulize.gsub(Tuxedo.config.suffix, '').underscore
    end

    # @api private
    # This setup (after initialize) a new method for accessing the original object
    # alias_method wont work well with inheritance/includes/extends
    #
    def setup_alias_method(name = underscored_name)
      define_method(name) { object }
    end
  end

  # Helper method that delegates to the view context
  # this allows you to call the url helpers from Rails
  #
  #   _h.link_to ...
  #
  # @return [ActionView::Context]
  #
  def _h
    @view_context
  end

  # Define delegations of our prac helper to the view context, allows to call prac inside the
  # presenters
  delegate(:prac, to: :_h)

  # These methods are already defined on Object by default or by rails, so we
  # have to explicitly delegate them to the model.
  delegate(:to_param, to: :object)
end
