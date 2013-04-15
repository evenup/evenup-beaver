require 'spec_helper'

describe 'beaver::config', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should contain_concat('/etc/beaver.conf') }
  it { should contain_concat__fragment('beaver.conf_header').with_order('01') }

end
