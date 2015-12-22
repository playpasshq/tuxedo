require 'rails/railtie'

module Tuxedo
  class Railtie < ::Rails::Railtie
    initializer 'tuxedo.action_view' do
      ActiveSupport.on_load :action_view do
        include Tuxedo::ActionView::Helpers
      end
    end
  end
end
