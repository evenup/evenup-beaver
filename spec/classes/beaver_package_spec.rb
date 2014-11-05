require 'spec_helper'

describe 'beaver' do

  context 'package' do

    it { should contain_class('beaver::package') }

    context 'default' do
      it { should contain_package('beaver').with(:ensure => 'installed', :provider => 'pip') }
      it { should contain_file('/etc/init.d/beaver') }
      it { should contain_file('/etc/beaver/conf.d').with_ensure('directory') }
    end

    context 'set package options' do
      let(:params) do {
        :package_name     => 'python-beaver',
        :package_provider => 'yum',
        :version          => 'latest'
      } end

      it { should contain_package('python-beaver').with(:ensure => 'latest', :provider => 'yum') }
    end
    
    context 'set provider option' do
      let(:params) do {
	:package_provider => 'virtualenv',
	:package_name     => 'beaver',
	:venv             => '/home/beaver/venv',
	:user             => 'beaver',
	:group            => 'beaver',
	:python_version   => '2.7'
      } end

      it { should contain_python__virtualenv('/home/beaver/venv') }
      it { should contain_python__pip('beaver') }
      it { should contain_user('beaver') }
    end

  end

end
