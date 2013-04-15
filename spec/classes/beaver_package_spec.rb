require 'spec_helper'

describe 'beaver::package', :type => :class do

  it { should contain_package('python-beaver') }
  it { should contain_file('/etc/init.d/beaver') }

end
