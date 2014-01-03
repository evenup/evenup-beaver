require 'spec_helper'

describe 'beaver', :type => :class do

  context 'service' do
    context 'default' do
      it { should contain_service('beaver').with_ensure('running').with_enable('true') }
    end

    context 'disabled' do
      let(:params) { { :enable => false } }

      it { should contain_service('beaver').with_ensure('stopped').with_enable('false') }
    end
  end
end
