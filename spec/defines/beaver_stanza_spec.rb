require 'spec_helper'

describe 'beaver::stanza', :type => :define do
  let(:title) { '/var/log/messages' }
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  context 'type only' do
    let(:params) { { :type => 'messages' } }

    it { should contain_concat__fragment('beaver.conf_/var/log/messages').with_content(/^\[\/var\/log\/messages\]$/) }
    it { should contain_concat__fragment('beaver.conf_/var/log/messages').with_content(/^type:\smessages$/) }

  end

  context 'with source, tags, format' do
    let(:params) { {
      :type   => 'messages',
      :source => '/var/local/log/messages',
      :format => 'rawjson',
      :tags   => ['tag1', 'tag2']
    } }

    it { should contain_concat__fragment('beaver.conf_/var/log/messages').with_content(/^\[\/var\/local\/log\/messages\]$/) }
    it { should contain_concat__fragment('beaver.conf_/var/log/messages').with_content(/^tags:\stag1\,tag2$/) }
    it { should contain_concat__fragment('beaver.conf_/var/log/messages').with_content(/^format:\srawjson$/) }
  end

  context 'with redis' do
    let(:params) { {
      :type             => 'messages',
      :redis_url        => 'redis://localhost:6379/',
      :redis_namespace  => 'logstash:beaver'
    } }

    it { should contain_concat__fragment('beaver.conf_/var/log/messages').with_content(/^redis_url:\sredis:\/\/localhost:6379\/$/) }
    it { should contain_concat__fragment('beaver.conf_/var/log/messages').with_content(/^redis_namespace:\slogstash:beaver$/) }
  end

end
