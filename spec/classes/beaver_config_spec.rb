require 'spec_helper'

describe 'beaver', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  context 'config' do
    it { should contain_file('/etc/beaver/beaver.conf') }
    skip "it should test the contents"
  end

end
