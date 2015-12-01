require 'spec_helper'

describe 'beaver::stanza', :type => :define do

  context 'filename substitution' do
    let(:title) { '/var/:something'}
    let(:params) { { :type => 'messages' } }

    it { should contain_file('/etc/beaver/conf.d/_var__something') }
  end

  context 'type only' do
    let(:title) { '/var/log/messages' }
    let(:params) { { :type => 'messages' } }

    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^\[\/var\/log\/messages\]$/) }
    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^type:\smessages$/) }
  end

  context 'with source, tags, format' do
    let(:title) { '/var/log/messages' }
    let(:params) { {
      :type   => 'messages',
      :source => '/var/local/log/messages',
      :format => 'rawjson',
      :tags   => ['tag1', 'tag2']
    } }

    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^\[\/var\/local\/log\/messages\]$/) }
    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^tags:\stag1\,tag2$/) }
    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^format:\srawjson$/) }
  end

  context 'with redis' do
    let(:title) { '/var/log/messages' }
    let(:params) { {
      :type             => 'messages',
      :redis_url        => 'redis://localhost:6379/',
      :redis_namespace  => 'logstash:beaver'
    } }

    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^redis_url:\sredis:\/\/localhost:6379\/$/) }
    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^redis_namespace:\slogstash:beaver$/) }
  end

  context 'set sincedb_write_interval' do
    let(:title) { '/var/log/messages' }
    let(:params) { {
      :type                   => 'messages',
      :sincedb_write_interval => 10
    } }

    it { should contain_file('/etc/beaver/conf.d/_var_log_messages').with_content(/^sincedb_write_interval:\s+10$/) }
  end

  context 'filename regex' do
    let(:title) {'/var/log/messages:*.log'}
    let(:params) { {
      :type => 'json'
    } }
    it { should contain_file('/etc/beaver/conf.d/_var_log_messages__.log') }
  end

end
