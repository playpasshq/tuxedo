require 'spec_helper'

RSpec.describe Tuxedo::ActionView::Helpers do
  let(:helper_class) { Struct.new(:helper) { include Tuxedo::ActionView::Helpers } }
  let(:helper) { helper_class.new }
  describe 'presenter_for' do
    subject { helper.presenter_for(Dummy.new) }

    context 'when providing instance' do
      specify { expect(subject).to be_an_instance_of(DummyPresenter) }
    end

    context 'when providing a different instance' do
      subject { helper.presenter_for(Dummy.new, Dummy2Presenter) }
      specify { expect(subject).to be_an_instance_of(Dummy2Presenter) }
    end

    context 'when provided object is nil' do
      subject { helper.presenter_for(nil) }
      specify { expect(subject).to be_nil }
    end

    context 'when used with a block' do
      specify { expect { |block| helper.presenter_for(Dummy.new, &block) }.to yield_control }
      specify { expect { |block| helper.presenter_for(Dummy.new, &block) }.to yield_with_args(instance_of(DummyPresenter)) }
      specify do
        expect do |block|
          helper.presenter_for(Dummy.new, Dummy2Presenter, &block)
        end.to yield_with_args(instance_of(Dummy2Presenter)) end
    end

    context 'when presenter does not exist' do
      subject { helper.presenter_for(UnknownKlass) }
      specify { expect { subject }.to raise_error(NameError) }
    end
  end

  describe 'prac' do
    subject { helper.prac Dummy.new, :name }

    it 'delegates to presenter_for' do
      expect(helper).to receive(:presenter_for).with(instance_of(Dummy)).and_call_original
      subject
    end

    context 'providing a valid method name' do
      it 'calls the method on the presenter' do
        expect_any_instance_of(DummyPresenter).to receive(:name)
        subject
      end

      context 'with extra arguments' do
        subject { helper.prac Dummy.new, :name_with_args, 'Jan', surname: 'Stevens' }
        it 'calls the method with arguments on the presenter' do
          expect_any_instance_of(DummyPresenter).to receive(:name_with_args).with('Jan', surname: 'Stevens')
          subject
        end
      end
    end

    context 'when the object is nil' do
      subject { helper.prac nil, :name }
      it 'should return nil' do
        expect(subject).to be_nil
      end
    end

    context 'when the method is nil' do
      subject { helper.prac Dummy.new, nil }
      it 'should return nil' do
        expect(subject).to be_nil
      end
    end
  end
end
