require 'rails/railtie'

# Tuxedo main module
module Tuxedo
  # Railtie that allows to include the Tuxedo::ActionView::Helpers
  # makes it possible to use `prac` and `presenter_for`
  class Railtie < ::Rails::Railtie
    initializer 'tuxedo.action_view' do
      ActiveSupport.on_load :action_view do
        include Tuxedo::ActionView::Helpers
      end
    end
  end
end
