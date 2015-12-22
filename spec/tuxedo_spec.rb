require 'spec_helper'

RSpec.describe Tuxedo do
  let(:view_class) { Struct.new(:view) { include Tuxedo::ActionView::Helpers } }
  let(:view) { view_class.new }
  let(:dummy) { Dummy.new }
  let(:presenter_instance) { OverwriteNamePresenter.new(dummy, view) }

  it 'addes an alias to the original object using the class name by default' do
    expect(presenter_instance).to respond_to(:overwrite_name)
  end

  describe '#_h' do
    subject { presenter_instance._h }
    it 'returns the view context' do
      expect(subject).to eq view
    end
  end

  describe '#prac' do
    subject { presenter_instance.prac(dummy, :name) }
    it 'delegates prac to the view context' do
      expect_any_instance_of(DummyPresenter).to receive(:name)
      subject
    end
  end

  describe '#to_param' do
    subject { presenter_instance.to_param }
    it 'delegates to the object' do
      expect(dummy).to receive(:to_param)
      subject
    end
  end

  describe '.object_alias' do
    after :each do
      OverwriteNamePresenter.object_alias(nil)
    end
    subject { OverwriteNamePresenter.object_alias(:cookies) }
    it 'allows to overwrite the alias to access the object' do
      subject
      expect(presenter_instance.cookies).to eq(dummy)
    end
  end
end
