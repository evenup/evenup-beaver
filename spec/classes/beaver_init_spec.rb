require 'spec_helper'

describe 'beaver', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should create_class('beaver') }

end
