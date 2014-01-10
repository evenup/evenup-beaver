require 'spec_helper'

describe 'beaver', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should create_class('beaver') }

  context 'validation' do
    context [ 'redis_db', 'redis_port' ].each do |param|
      context param do
        context 'should accept integers' do
          let(:params) { { :redis_db => 100 } }
          it { expect { should_not raise_error(Puppet::Error) } }
        end
        context 'should not accept strings' do
          let(:params) { { :redis_db => 'boo' } }
          it { expect { should raise_error(Puppet::Error) } }
        end
      end
    end # integers

    [ 'enable', 'enable_sincedb' ].each do |param|
      context param do
        context 'should accept a bool' do
          let(:params) { { param => true } }
          it { expect { should_not raise_error(Puppet::Error) } }
        end
        context 'should not accept a string' do
          let(:params) { { param => 'boo' } }
          it { expect { should_not raise_error(Puppet::Error) } }
        end
      end
    end # bools

    context 'logstash_version' do
      context 'should accept 0' do
        let(:params) { { :logstash_version => 0 } }
        it { expect { should_not raise_error(Puppet::Error) } }
      end
      context 'should accept 1' do
        let(:params) { { :logstash_version => 1 } }
        it { expect { should_not raise_error(Puppet::Error) } }
      end
      context 'should not accept 2' do
        let(:params) { { :logstash_version => 2 } }
        it { expect { should raise_error(Puppet::Error) } }
      end
    end
  end
end
