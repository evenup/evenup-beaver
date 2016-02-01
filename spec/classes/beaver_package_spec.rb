require 'spec_helper'

describe 'beaver' do
  let(:facts) { { :virtualenv_version => 'absent' } }

  context 'package' do

    it { should contain_class('beaver::package') }

    context 'default' do
      it { should contain_package('beaver').with(:ensure => 'present', :provider => 'pip') }
      it { should contain_file('/lib/systemd/system/beaver.service') }
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

    context 'specify version with pip provider' do
      let(:params) do {
        :package_name     => 'beaver',
        :package_provider => 'pip',
        :version          => '33.3.0'
      } end

      it { should contain_package('beaver').with(:ensure => '33.3.0', :provider => 'pip') }
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

    context 'service provider' do
      ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux', 'SLC'].each do |operatingsystem|
        context 'version 7' do
          let(:facts) { { :operatingsystem => operatingsystem, :operatingsystemmajrelease => '7' } }
          it { should contain_file('/lib/systemd/system/beaver.service') }
          it { should contain_file('/etc/init.d/beaver').with_ensure('absent') }
        end

        context 'version 6' do
          let(:facts) { { :operatingsystem => operatingsystem, :operatingsystemmajrelease => '6' } }
          it { should contain_file('/etc/init.d/beaver') }
          it { should_not contain_file('/lib/systemd/system/beaver.service') }
        end
      end

      context 'Debian version 8' do
        let(:facts) { { :operatingsystem => 'Debian', :operatingsystemmajrelease => '8' } }
        it { should contain_file('/lib/systemd/system/beaver.service') }
        it { should contain_file('/etc/init.d/beaver').with_ensure('absent') }
      end

      context 'Debian version 7' do
        let(:facts) { { :operatingsystem => 'Debian', :operatingsystemmajrelease => '7' } }
        it { should contain_file('/etc/init.d/beaver') }
        it { should_not contain_file('/lib/systemd/system/beaver.service') }
      end

      context 'Ubuntu version 15.04' do
        let(:facts) { { :operatingsystem => 'Ubuntu', :operatingsystemmajrelease => '15.04' } }
        it { should contain_file('/lib/systemd/system/beaver.service') }
        it { should contain_file('/etc/init.d/beaver').with_ensure('absent') }
      end

      context 'Ubuntu version 14.04' do
        let(:facts) { { :operatingsystem => 'Ubuntu', :operatingsystemmajrelease => '14.04' } }
        it { should contain_file('/etc/init.d/beaver') }
        it { should_not contain_file('/lib/systemd/system/beaver.service') }
      end
    end

  end

end
