module Tuxedo
  module ActionView
    # Main module for the ActionView helpers
    #
    # @example
    #
    #   presenter_for(instance)
    #
    #   prac(instance, method, *args)
    #
    module Helpers
      # We can use this to give a block and wrap all the presenter methods
      # in the block. This shows clearly that we are using a presenter
      # without the explicit assign statement. Some magic happens to initiate
      # a new presenter with the model and the view context
      #
      # @param model[Object] any type of object that needs to be presented
      # @param klass [KlassName] a different presenter klass
      # @return model presenter instance
      #
      def presenter_for(model, klass = nil)
        return if model.nil?
        klass ||= "#{model.class.name}#{Tuxedo.config.suffix}".constantize
        presenter = klass.new(model, self)
        yield presenter if block_given?
        presenter
      end

      # Present And Call
      # Shorthand method for using the following call
      #
      #   presenter_for(object).zone_label
      #
      # @example
      #
      #   prac object, :zone_label
      #
      # @param object [Object]
      # @param method [method] the method we should call on the presentor
      # @param args [Hash] optional arguments for the method
      #
      def prac(object, method, *args)
        return if object.nil? || method.nil?
        presenter_for(object).send(method.to_sym, *args)
      end
    end
  end
end
