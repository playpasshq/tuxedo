require 'rails/railtie'

module Tuxedo
  class Railtie < ::Rails::Railtie
    initializer 'tuxedo.action_view' do |_app|
      ActiveSupport.on_load :action_view do
        require 'tuxedo/action_view/helpers'
        include Tuxedo::ActionView::Helpers
      end
    end
  end
end
