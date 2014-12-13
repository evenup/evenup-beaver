require 'spec_helper_acceptance'

describe 'beaver classes' do

  context 'defaults' do
    if fact('osfamily') == 'RedHat'
      it 'adds epel and installs pip' do
        pp = "class { 'epel': }"
        apply_manifest(pp, :catch_failures => true)
        shell("yum -y install python-pip")
      end
    end

    if fact('osfamily') == 'Debian'
      it 'installs pip' do
        shell("apt-get -y install python-pip")
      end
    end

    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'beaver': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe command('python -c "import beaver"') do
      its(:exit_status) { should eq 0 }
    end

    describe service('beaver') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

  end

end
