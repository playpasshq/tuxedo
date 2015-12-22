require 'spec_helper'

RSpec.describe Tuxedo do
  describe 'suffix' do
    specify { expect(Tuxedo.config.suffix).to eq 'Presenter' }
    context 'configured via config block' do
      before do
        Tuxedo.configure { |config| config.suffix = 'Pre' }
      end
      specify { expect(Tuxedo.config.suffix).to eq 'Pre' }

      after do
        Tuxedo.configure { |config| config.suffix = 'Presenter' }
      end
    end
  end
end
